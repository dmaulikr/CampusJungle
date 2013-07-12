//
//  CCSelectGroupViewController.m
//  CampusJungle
//
//  Created by Yury Grinenko on 11.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCSelectGroupsViewController.h"
#import "CCClass.h"
#import "CCGroup.h"

#import "CCSelectableCellsDataSource.h"
#import "CCGroupsDataProvider.h"
#import "CCStandardErrorHandler.h"

#import "CCGroupSelectionCell.h"

@interface CCSelectGroupsViewController ()

@property (nonatomic, strong) CCClass *classObject;
@property (nonatomic, copy) ShareItemButtonSuccessBlock successBlock;
@property (nonatomic, copy) ShareItemButtonCancelBlock cancelBlock;

@property (nonatomic, strong) CCGroupsDataProvider *dataProvider;
@property (nonatomic, strong) CCSelectableCellsDataSource *dataSource;

@end

@implementation CCSelectGroupsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupTableView];
    [self setRightNavigationItemWithTitle:@"Share" selector:@selector(shareButtonDidPressed:)];
    [self setTitle:@"Select Groups"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}

- (void)setupTableView
{
    self.dataSource = [CCSelectableCellsDataSource new];
    self.dataProvider = [CCGroupsDataProvider new];
    self.dataProvider.classId = self.classObject.classID;
    [self configTableWithProvider:self.dataProvider cellClass:[CCGroupSelectionCell class]];
}

#pragma mark -
#pragma mark Actions
- (void)setClass:(CCClass *)classObject
{
    _classObject = classObject;
}

- (void)shareButtonDidPressed:(id)sender
{
    NSArray *selectedGroupsArray = [self selectedGroupsArray];
    if ([selectedGroupsArray count] == 0) {
        [CCStandardErrorHandler showErrorWithTitle:CCAlertsTitles.defaultError message:CCAlertsMessages.noSelectedItems];
        return;
    }

    [self.backTransaction perform];
    if (self.successBlock) {
        self.successBlock(selectedGroupsArray);
    }
}

- (NSArray *)selectedGroupsArray
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"isSelected == YES"];
    return [self.dataProvider.arrayOfItems filteredArrayUsingPredicate:predicate];;
}

@end
