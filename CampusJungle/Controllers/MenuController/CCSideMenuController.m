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

@interface CCSideMenuController () <CCCellSelectionProtocol>

@property (nonatomic, strong) CCSideMenuDataSource *dataSource;
@property (nonatomic, strong) CCSideMenuDataProvider *dataProvider;

@end

@implementation CCSideMenuController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configTable];
}

- (void)configTable
{
    self.dataProvider = [CCSideMenuDataProvider new];
    self.dataProvider.arrayOfMenuItems = @[CCSideMenuTitles.profile,CCSideMenuTitles.classesScreen,CCSideMenuTitles.market];
    [self configTableWithProvider:self.dataProvider cellClass:[CCOrdinaryCell class]];
}

- (void)didSelectedCellWithObject:(id)cellObject
{
    if ([(NSString*)cellObject isEqualToString:CCSideMenuTitles.profile]) {
        [self.userProfileTransaction perform];

    } else if([(NSString*)cellObject isEqualToString:CCSideMenuTitles.classesScreen]) {
        [self.classesTransaction perform];
    } else if([(NSString*)cellObject isEqualToString:CCSideMenuTitles.market]){
        [self.marketTransaction perform];
    }
}

@end