//
//  CCLocationsViewController.m
//  CampusJungle
//
//  Created by Yury Grinenko on 09.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCLocationsViewController.h"
#import "CCLocation.h"
#import "CCClass.h"
#import "CCClassLocationsDataProvider.h"
#import "CCLocationsDataSource.h"
#import "CCNavigationBarViewHelper.h"

#import "CCMapHelper.h"
#import "CCLocationCell.h"

#import "CCLocationDataProviderDelegate.h"

@interface CCLocationsViewController () <CCLocationDataProviderDelegate>

@property (nonatomic, weak) IBOutlet MKMapView *mapView;

@property (nonatomic, strong) CCClass *classObject;
@property (nonatomic, strong) NSMutableArray *locationsArray;
@property (nonatomic, strong) CCLocation *selectedLocation;
@property (nonatomic, strong) NSString *searchString;
@property (nonatomic, strong) CCClassLocationsDataProvider *dataProvider;
@property (nonatomic, strong) CCLocationsDataSource *dataSource;
@property (nonatomic, assign) Class dataSourceClass;

@end

@implementation CCLocationsViewController

- (id)initWithLocationsArray:(NSArray *)locationsArray
{
    self = [super init];
    if (self) {
        self.locationsArray = [NSMutableArray arrayWithArray:locationsArray];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupTableView];
    [self setupSearchBar];
    [self addObservers];
    
    self.navigationItem.rightBarButtonItem = [CCNavigationBarViewHelper plusButtonWithTarget:self action:@selector(addLocation)];
    [self setTitle:@"Locations"];
    
    [(UIScrollView *)self.view setScrollEnabled:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    if (self.selectedLocation) {
        [CCMapHelper focusOnLocation:self.selectedLocation inMap:self.mapView];
    }
}

- (void)dealloc
{
    [self removeObservers];
}

- (void)addObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadLocations) name:CCNotificationsNames.reloadClassLocations object:nil];
}

- (void)removeObservers
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CCNotificationsNames.reloadClassLocations object:nil];
}

- (void)setupSearchBar
{
    [self.searchBar setText:self.searchString];
}

- (void)setupTableView
{
    self.dataSource = [CCLocationsDataSource new];
    self.dataSourceClass = [CCLocationsDataSource class];
    self.dataProvider = [[CCClassLocationsDataProvider alloc] initWithDelegate:self];
    self.dataProvider.classId = self.classObject.classID;
    [self configTableWithProvider:self.dataProvider cellClass:[CCLocationCell class]];
}

#pragma mark -
#pragma mark Overriding base methods
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self performSelector:@selector(configSearchBar) withObject:nil afterDelay:0.01];
    self.dataSource.dataProvider.searchQuery = searchText;
    self.lastSearchPressTime = [NSDate date];
    
    double delayInSeconds = 1.1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        if([[NSDate date] timeIntervalSinceDate:self.lastSearchPressTime] >= 1){
            [self.dataSource.dataProvider loadItems];
        }
    });
}

#pragma mark -
#pragma mark Actions
- (void)setClass:(CCClass *)classObject
{
    _classObject = classObject;
}

- (void)reloadLocations
{
    [self.dataProvider loadItems];
}

- (void)addLocation
{
    [self.addLocationTransaction performWithObject:self.classObject];
}

#pragma mark -
#pragma mark CCLocationDataProviderDelegate
- (void)didLoadLocations:(NSArray *)locationsArray
{
    [CCMapHelper createAnnotationsOnMap:self.mapView withLocationsArray:locationsArray];
    if (!self.selectedLocation) {
        [CCMapHelper makeVisibleAllLocations:locationsArray onMap:self.mapView];
    }
    else {
        self.selectedLocation = nil;
    }
}

- (void)didSelectedCellWithObject:(id)cellObject
{
    [CCMapHelper focusOnLocation:cellObject inMap:self.mapView];
}

@end
