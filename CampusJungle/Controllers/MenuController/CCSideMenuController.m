//
//  CCMenuControllerViewController.m
//  CollegeConnect
//
//  Created by Vlad Korzun on 21.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCSideMenuController.h"
#import "CCSideMenuDataSource.h"
#import "CCSideMenuDataProvider.h"
#import "CCOrdinaryCell.h"
#import "CCMenuDefines.h"
#import "CCUserSessionProtocol.h"
#import "CCClassesApiProviderProtocol.h"

@interface CCSideMenuController () <CCCellSelectionProtocol, CCSideMenuDelegate>

@property (nonatomic, strong) id <CCUserSessionProtocol> ioc_userProfile;
@property (nonatomic, strong) id <CCClassesApiProviderProtocol> ioc_classesAPI;
@property (nonatomic, strong) CCSideMenuDataSource *dataSource;
@property (nonatomic, strong) CCSideMenuDataProvider *dataProvider;
@property (nonatomic, weak) IBOutlet UILabel *userNameLabel;

@end

@implementation CCSideMenuController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.userNameLabel.text = [NSString stringWithFormat:@"%@ %@",[[self.ioc_userProfile currentUser] firstName], [[self.ioc_userProfile currentUser] lastName]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadUserClasses];
}

- (void)setupTableViewWithEducationsArray:(NSArray *)educationsArray
{
//    self.dataProvider = [CCSideMenuDataProvider new];
//    self.dataProvider.arrayOfMenuItems = [CCSideMenuDataSourceHelper menuSectionsArrayWithEducationsArray:educationsArray];
//    [self configTableWithProvider:self.dataProvider cellClass:[CCMenuCell class]];
    self.dataSource = [[CCSideMenuDataSource alloc] initWithDelegate:nil sectionsArray:educationsArray];
    [self.mainTable setDataSource:self.dataSource];
    [self.mainTable setDelegate:self.dataSource];
    [self.mainTable reloadData];
}

- (void)didSelectedCellWithObject:(id)cellObject
{
    if ([(NSString*)cellObject isEqualToString:CCSideMenuTitles.profile]) {
        [self.userProfileTransaction perform];
    } else if([(NSString*)cellObject isEqualToString:CCSideMenuTitles.classesScreen]) {
        [self.classesTransaction perform];
    } else if([(NSString*)cellObject isEqualToString:CCSideMenuTitles.marketPlace]){
        [self.marketTransaction perform];
    } else if ([(NSString *)cellObject isEqualToString:@"Inbox"]){
        [self.inboxTransaction perform];
    }
}

- (void)loadUserClasses
{
    __weak CCSideMenuController *weakSelf = self;
    [self.ioc_classesAPI getClassesInCollegesWithSuccessHandler:^(NSArray *educationsArray) {
        [weakSelf setupTableViewWithEducationsArray:educationsArray];
    } errorHandler:^(NSError *error) {
        [CCStandardErrorHandler showErrorWithError:error];
    } ];
}

@end