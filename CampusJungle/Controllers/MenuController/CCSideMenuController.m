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
#import "CCMenuCell.h"

@interface CCSideMenuController () <CCCellSelectionProtocol>

@property (nonatomic, strong) id <CCUserSessionProtocol> ioc_userProfile;
@property (nonatomic, strong) CCSideMenuDataSource *dataSource;
@property (nonatomic, strong) CCSideMenuDataProvider *dataProvider;
@property (nonatomic, weak) IBOutlet UILabel *userNameLabel;

@end

@implementation CCSideMenuController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configTable];
    self.userNameLabel.text = [NSString stringWithFormat:@"%@ %@",[[self.ioc_userProfile currentUser] firstName], [[self.ioc_userProfile currentUser] lastName]];
}

- (void)configTable
{
    self.dataProvider = [CCSideMenuDataProvider new];
    self.dataProvider.arrayOfMenuItems = @[CCSideMenuTitles.profile,CCSideMenuTitles.classesScreen,CCSideMenuTitles.market,@"Inbox"];
    [self configTableWithProvider:self.dataProvider cellClass:[CCMenuCell class]];
}

- (void)didSelectedCellWithObject:(id)cellObject
{
    if ([(NSString*)cellObject isEqualToString:CCSideMenuTitles.profile]) {
        [self.userProfileTransaction perform];

    } else if([(NSString*)cellObject isEqualToString:CCSideMenuTitles.classesScreen]) {
        [self.classesTransaction perform];
    } else if([(NSString*)cellObject isEqualToString:CCSideMenuTitles.market]){
        [self.marketTransaction perform];
    } else if ([(NSString *)cellObject isEqualToString:@"Inbox"]){
        [self.inboxTransaction perform];
    }
}

@end