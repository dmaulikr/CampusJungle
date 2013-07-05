//
//  CCMarketPlaceController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 12.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCMarketPlaceController.h"
#import "CCMarketNotesProvider.h"
#import "CCDefines.h"
#import "CCCommonCollectionDataSource.h"
#import "CCNotesCollectionCell.h"
#import "CCClassesApiProviderProtocol.h"
#import "CCStandardErrorHandler.h"
#import "CCUserSessionProtocol.h"
#import "CCAPIProviderProtocol.h"
#import "CCMarketStuffDataProvider.h"
#import "CCEducation.h"
#import "CCNote.h"

@interface CCMarketPlaceController ()<CCCellSelectionProtocol>

@property (nonatomic, weak) IBOutlet UICollectionView *topNotesCollectionView;
@property (nonatomic, weak) IBOutlet UICollectionView *latestNotesCollectionView;
@property (nonatomic, weak) IBOutlet UICollectionView *latestStuffCollectionView;

@property (nonatomic, strong) CCMarketNotesProvider *marketLatestNotesProvider;
@property (nonatomic, strong) CCMarketNotesProvider *marketTopNotesProvider;
@property (nonatomic, strong) CCMarketStuffDataProvider *marketStuffDataProvider;
@property (nonatomic, strong) NSMutableArray *arrayOfDataSources;
@property (nonatomic, strong) id <CCClassesApiProviderProtocol> ioc_classesAPIProvider;
@property (nonatomic, strong) id <CCUserSessionProtocol> ioc_userSessionProtocol;
@property (nonatomic, strong) id <CCAPIProviderProtocol> ioc_APIProvider;

@end

@implementation CCMarketPlaceController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.arrayOfDataSources = [NSMutableArray new];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Filters" style:UIBarButtonItemStyleBordered target:self action:@selector(applyFilters)];
    self.marketLatestNotesProvider = [CCMarketNotesProvider new];
    self.marketLatestNotesProvider.order = CCMarketFilterConstants.orderLatest;
    
    self.marketTopNotesProvider = [CCMarketNotesProvider new];
    self.marketTopNotesProvider.order = CCMarketFilterConstants.orderTop;
    
    self.marketStuffDataProvider = [CCMarketStuffDataProvider new];
    self.marketStuffDataProvider.order = CCMarketFilterConstants.orderTop;
    
    [self configCollection:self.latestStuffCollectionView WithProvider:self.marketStuffDataProvider cellClass:[CCNotesCollectionCell class]];
    
    [self configCollection:self.topNotesCollectionView WithProvider:self.marketTopNotesProvider cellClass:[CCNotesCollectionCell class]];
    
    [self configCollection:self.latestNotesCollectionView WithProvider:self.marketLatestNotesProvider cellClass:[CCNotesCollectionCell class]];
    
    [self.ioc_userSessionProtocol loadUserEducationsSuccessHandler:^(id educations){
        [self loadFilters];
    }];
    
    self.tapRecognizer.enabled = NO;
    self.title = @"Market";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self resetDataProviders];
}

- (void)update
{
    self.marketLatestNotesProvider.filters = self.filters;
    [self.marketLatestNotesProvider loadItems];
    self.marketTopNotesProvider.filters = self.filters;
    [self.marketTopNotesProvider loadItems];
    self.marketStuffDataProvider.filters = self.filters;
    [self.marketStuffDataProvider loadItems];
}

- (void)applyFilters
{
    [self.filtersScreenTransaction performWithObject:self];
}

- (void)configCollection:(UICollectionView *)collectionView WithProvider:(CCBaseDataProvider *)provider cellClass:(Class)cellCass
{
    CCCommonCollectionDataSource *dataSource = [CCCommonCollectionDataSource new];
    [self.arrayOfDataSources addObject:dataSource];
    
    [collectionView registerClass:cellCass forCellWithReuseIdentifier:CCTableDefines.collectionCellIdentifier];
    
    dataSource.dataProvider = provider;
    dataSource.dataProvider.targetTable = (UITableView *)collectionView;
    collectionView.dataSource = dataSource;
    collectionView.delegate = dataSource;
    
    dataSource.delegate = self;
}

- (void)didSelectedCellWithObject:(id)cellObject
{
    if([cellObject isKindOfClass:[CCNote class]]){
        [self.noteDetailsTransaction performWithObject:cellObject];
    } else {
        [self.stuffDetailsTransaction performWithObject:cellObject];
    }
}

- (void)loadFilters
{
    NSArray *arrayOfColleges = [CCEducation arrayOfCollegesIDFromEducations:[[self.ioc_userSessionProtocol currentUser] educations]];
     self.filters = @{
        CCMarketFilterConstants.colleges : arrayOfColleges,
        CCMarketFilterConstants.classes :@[]
     };
    
     [self update];
}

- (BOOL)isString:(NSString *)string inArray:(NSArray *)array
{
    for(NSString *stringFromArray in array){
        if([string isEqualToString:stringFromArray]){
            return YES;
        }
    }
    return NO;
}

- (void)resetDataProviders
{
    self.marketLatestNotesProvider.targetTable = (UITableView *)self.latestNotesCollectionView;
    self.marketTopNotesProvider.targetTable = (UITableView *)self.topNotesCollectionView;
    self.marketStuffDataProvider.targetTable = (UITableView *)self.latestStuffCollectionView;
    
    self.marketTopNotesProvider.searchQuery = nil;
    self.marketLatestNotesProvider.searchQuery = nil;
    self.marketStuffDataProvider.searchQuery = nil;
    
    [self update];
}

- (IBAction)viewAllTopNotesPressed
{
    [self.fullListOfNotesTransaction performWithObject:self.marketTopNotesProvider];
}

- (IBAction)viewAllLatestNotesPressed
{
    [self.fullListOfNotesTransaction performWithObject:self.marketLatestNotesProvider];
}

- (IBAction)viewAllStuffButtonPressed
{
    [self.fullListOfStuffTransaction performWithObject:self.marketStuffDataProvider];
}

@end
