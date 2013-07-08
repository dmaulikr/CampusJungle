//
//  CCClassTableController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 08.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCClassTableController.h"
#import "CCClassControllerTableDataSource.h"
#import "CCClassmatesDataProvider.h"
#import "CCUserCell.h"
#import "CCClassTabbarControllerViewController.h"

@interface CCClassTableController ()<CCClassTabbarControllerDelegateProtocol>

@property (nonatomic, weak) IBOutlet UIView *sectionHeaderView;
@property (nonatomic, strong) CCClassTabbarControllerViewController *classTabbarController;
@property (nonatomic, strong) CCClassmatesDataProvider *classmatesProvider;

@end

@implementation CCClassTableController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataSourceClass = [CCClassControllerTableDataSource class];
   
    self.dataSource = [CCClassControllerTableDataSource new];
    
    CCClassTabbarControllerViewController *tabbarController = [CCClassTabbarControllerViewController new];
    tabbarController.delegate = self;
    self.classTabbarController = tabbarController;
    
    [self.sectionHeaderView addSubview:tabbarController.view];
    [(CCClassControllerTableDataSource *)self.dataSource setViewForSectionHeader:self.sectionHeaderView];
    self.mainTable.tableHeaderView = self.tableHeaderView;
}

- (void)setClassmatesConfiguration
{
    if(!self.classmatesProvider){
        self.classmatesProvider = [CCClassmatesDataProvider new];
        self.classmatesProvider.classID = self.classID;
    }
    
    self.searchBar.hidden = NO;
    [self updateSectionHeaderViewSize];
    [self configTableWithProvider:self.classmatesProvider cellClass:[CCUserCell class]];
}

- (void)setForumsConfiguration
{

}

- (void)setLocationConfiguration
{

}

- (void)setGroupsConfiguration
{

}

- (void)updateSectionHeaderViewSize
{
    CGFloat height = 0;
    if(self.searchBar.hidden){
        height = self.classTabbarController.view.bounds.size.height;
    } else {
        height = self.classTabbarController.view.bounds.size.height + self.searchBar.bounds.size.height;
    }
    
    self.sectionHeaderView.bounds = CGRectMake(0, 0, self.sectionHeaderView.bounds.size.width, height);
}

- (void)didSelectBarItemWithIdentifier:(NSInteger)identifier
{
    switch (identifier) {
        case CCClassTabbarButtonsIdentifierClassmate:{
            [self setClassmatesConfiguration];
        }break;
        case CCClassTabbarButtonsIdentifierGroup:{
            [self setGroupsConfiguration];
        }break;
        case CCClassTabbarButtonsIdentifierLocations:{
            [self setLocationConfiguration];
        }break;
        case CCClassTabbarButtonsIdentifierForums:{
            [self setForumsConfiguration];
        }break;
    }
}

-(void)didReselectBarItemWithIdentifier:(NSInteger)identifier
{
    [self.mainTable setContentOffset:CGPointZero animated:YES];
}

- (void)setTableHeaderView:(UIView *)tableHeaderView
{
    _tableHeaderView = tableHeaderView;
    self.mainTable.tableHeaderView = tableHeaderView;
}

@end
