//
//  CCLocationsViewController.m
//  CampusJungle
//
//  Created by Yury Grinenko on 09.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCLocationsViewController.h"
#import "CCLocation.h"
#import "CCClassLocationsDataProvider.h"

#import "CCMapHelper.h"
#import "CCLocationCell.h"

#import "CCLocationDataProviderDelegate.h"

@interface CCLocationsViewController () <CCLocationDataProviderDelegate>

@property (nonatomic, weak) IBOutlet MKMapView *mapView;

@property (nonatomic, strong) NSString *classId;
@property (nonatomic, strong) NSMutableArray *locationsArray;
@property (nonatomic, strong) CCLocation *selectedLocation;
@property (nonatomic, strong) CCClassLocationsDataProvider *locationsProvider;

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
}

- (void)setupTableView
{
    self.locationsProvider = [[CCClassLocationsDataProvider alloc] initWithDelegate:self];
    self.locationsProvider.classId = self.classId;
    [self configTableWithProvider:self.locationsProvider cellClass:[CCLocationCell class]];
}

#pragma mark -
#pragma mark Actions

#pragma mark -
#pragma mark CCLocationDataProviderDelegate
- (void)didLoadLocations:(NSArray *)locationsArray
{
    [CCMapHelper createAnnotationsOnMap:self.mapView withLocationsArray:locationsArray];
}

- (void)didSelectedCellWithObject:(id)cellObject
{
    [CCMapHelper focusOnLocation:cellObject inMap:self.mapView];
}

@end
