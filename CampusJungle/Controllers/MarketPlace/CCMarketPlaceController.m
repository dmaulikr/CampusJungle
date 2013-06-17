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

@interface CCMarketPlaceController ()<CCCellSelectionProtocol>

@property (nonatomic, weak) IBOutlet UICollectionView *topNotesCollectionView;
@property (nonatomic, weak) IBOutlet UICollectionView *latestNotesCollectionView;
@property (nonatomic, weak) IBOutlet UICollectionView *latestStuffCollectionView;

@property (nonatomic, strong) CCMarketNotesProvider *marketLatestNotesProvider;
@property (nonatomic, strong) CCMarketNotesProvider *marketTopNotesProvider;
@property (nonatomic, strong) NSMutableArray *arrayOfDataSources;
@property (nonatomic, strong) id <CCClassesApiProviderProtocol> ioc_classesAPIProvider;

@end

@implementation CCMarketPlaceController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.arrayOfDataSources = [NSMutableArray new];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Filters" style:UIBarButtonItemStyleBordered target:self action:@selector(applyFilters)];
    self.marketLatestNotesProvider = [CCMarketNotesProvider new];
    self.marketLatestNotesProvider.order = @"date";
    
    self.marketTopNotesProvider = [CCMarketNotesProvider new];
    self.marketTopNotesProvider.order = @"sales";
    
    [self configCollection:self.topNotesCollectionView WithProvider:self.marketTopNotesProvider cellClass:[CCNotesCollectionCell class]];
    
    [self configCollection:self.latestNotesCollectionView WithProvider:self.marketLatestNotesProvider cellClass:[CCNotesCollectionCell class]];
    
    [self loadFilters];
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
    [self.ioc_classesAPIProvider getAllClasesSuccessHandler:^(id result) {
        NSMutableArray *arrayOfColleges = [NSMutableArray new];
        for (CCClass *currentClass in result){
            if(![self isString:currentClass.collegeID inArray:arrayOfColleges]){
                [arrayOfColleges addObject:currentClass.collegeID];
            }
        }
     self.filters = @{
     @"colleges_ids" : arrayOfColleges,
     @"classes_ids" :@[]
     };
    
        NSLog(@"%@",self.filters);
     [self update];
    } errorHandler:^(NSError *error) {
        [CCStandardErrorHandler showErrorWithError:error];
    }];
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
    
    self.marketTopNotesProvider.query = nil;
    self.marketLatestNotesProvider.query = nil;
    
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
