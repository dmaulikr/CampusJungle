//
//  CCSelectClassmatesViewController.m
//  CampusJungle
//
//  Created by Yury Grinenko on 11.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCSelectClassmatesViewController.h"
#import "CCClass.h"
#import "CCUser.h"

#import "CCUserSelectionCell.h"
#import "CCStandardErrorHandler.h"

#import "CCSelectableCellsDataSource.h"
#import "CCClassmatesDataProvider.h"

@interface CCSelectClassmatesViewController ()

@property (nonatomic, strong) CCClass *classObject;
@property (nonatomic, strong) CCClassmatesDataProvider *dataProvider;
@property (nonatomic, strong) CCSelectableCellsDataSource *dataSource;
@property (nonatomic, copy) ShareItemButtonSuccessBlock successBlock;
@property (nonatomic, copy) ShareItemButtonCancelBlock cancelBlock;

@end

@implementation CCSelectClassmatesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupTableView];
    [self setRightNavigationItemWithTitle:@"Share" selector:@selector(shareButtonDidPressed:)];
    [self setTitle:@"Select Classmates"];
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
    self.dataProvider = [CCClassmatesDataProvider new];
    self.dataProvider.classID = self.classObject.classID;
    [self configTableWithProvider:self.dataProvider cellClass:[CCUserSelectionCell class]];
}

#pragma mark -
#pragma mark Actions
- (void)setClass:(CCClass *)classObject
{
    _classObject = classObject;
}

- (void)shareButtonDidPressed:(id)sender
{
    NSArray *selectedUsersArray = [self selectedUsersArray];
    if ([selectedUsersArray count] == 0) {
        [CCStandardErrorHandler showErrorWithTitle:CCAlertsTitles.defaultError message:CCAlertsMessages.noSelectedItems];
        return;
    }
    [self.backTransaction perform];
    if (self.successBlock) {
        self.successBlock(selectedUsersArray);
    }
}

- (NSArray *)selectedUsersArray
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"isSelected == YES"];
    return [self.dataProvider.arrayOfItems filteredArrayUsingPredicate:predicate];;
}

@end
