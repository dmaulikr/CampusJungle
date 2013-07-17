//
//  CCCommentsViewController.m
//  CampusJungle
//
//  Created by Yury Grinenko on 17.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCCommentsViewController.h"

#import "CCAnswer.h"
#import "CCComment.h"

#import "CCNavigationBarViewHelper.h"
#import "CCAnswerHeader.h"

#import "CCCommentsDataProvider.h"
#import "CCBaseReverseDataSource.h"
#import "CCCommentCell.h"

@interface CCCommentsViewController ()

@property (nonatomic, strong) CCAnswerHeader *tableHeaderView;
@property (nonatomic, strong) CCAnswer *answer;
@property (nonatomic, strong) CCCommentsDataProvider *dataProvider;
@property (nonatomic, strong) CCBaseReverseDataSource *dataSource;

@end

@implementation CCCommentsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupTableView];

    self.navigationItem.rightBarButtonItem = [CCNavigationBarViewHelper plusButtonWithTarget:self action:@selector(addCommentButtonDidPressed:)];
    [self setTitle:@"Comments"];
}

- (void)setupTableView
{
    self.tableHeaderView = [[CCAnswerHeader alloc] initWithAnswerText:self.answer.text bottomDividerVisibile:YES];
    self.mainTable.tableHeaderView = self.tableHeaderView;
    
    self.dataSource = [CCBaseReverseDataSource new];
    self.dataSource.delegate = self;
    
    self.dataProvider = [CCCommentsDataProvider new];
    self.dataProvider.answerId = self.answer.answerId;
    
    [self configTableWithProvider:self.dataProvider cellClass:[CCCommentCell class]];
}

#pragma mark -
#pragma mark Actions
- (void)addCommentButtonDidPressed:(id)sender
{
    
}

@end
