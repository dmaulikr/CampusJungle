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
#import "CCEducation.h"

@interface CCMarketPlaceController ()<CCCellSelectionProtocol>

@property (nonatomic, weak) IBOutlet UICollectionView *topNotesCollectionView;
@property (nonatomic, weak) IBOutlet UICollectionView *latestNotesCollectionView;
@property (nonatomic, weak) IBOutlet UICollectionView *latestStuffCollectionView;

@property (nonatomic, strong) CCMarketNotesProvider *marketLatestNotesProvider;
@property (nonatomic, strong) CCMarketNotesProvider *marketTopNotesProvider;
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
    
    [self configCollection:self.topNotesCollectionView WithProvider:self.marketTopNotesProvider cellClass:[CCNotesCollectionCell class]];
    
    [self configCollection:self.latestNotesCollectionView WithProvider:self.marketLatestNotesProvider cellClass:[CCNotesCollectionCell class]];
    
    [self loadUserEducationsSuccessHandler:^{
        [self loadFilters];
    }];
}

- (void)loadUserEducationsSuccessHandler:(successHandler)success
{
    CCUser *user = [self.ioc_userSessionProtocol currentUser];
    if(user.educations){
        success();
    } else {
        [self.ioc_APIProvider loadUserInfoSuccessHandler:^(id result) {
            [self.ioc_userSessionProtocol setCurrentUser:result];
            success();
        } errorHandler:^(NSError *error) {
            [CCStandardErrorHandler showErrorWithError:error];
        }];
    }
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
}

- (void)applyFilters
{
    [self.filtersScreenTransaction performWithObject:self];
}

- (void)configCollection:(UICollectionView *)collectionView WithProvider:(CCBaseDataProvider *)provider cellClass:(Class)cellCass
{
    [collectionView registerClass:cellCass forCellWithReuseIdentifier:CCTableDefines.collectionCellIdentifier];
    CCCommonCollectionDataSource *dataSource = [CCCommonCollectionDataSource new];

    dataSource.dataProvider = provider;
    dataSource.dataProvider.targetTable = (UITableView *)collectionView;
    collectionView.dataSource = dataSource;
    collectionView.delegate = dataSource;
    [self.arrayOfDataSources addObject:dataSource];
    dataSource.delegate = self;
}

- (void)didSelectedCellWithObject:(id)cellObject
{
    [self.noteDetailsTransaction performWithObject:cellObject];
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
    
    self.marketTopNotesProvider.searchQuery = nil;
    self.marketLatestNotesProvider.searchQuery = nil;
    
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

@end
