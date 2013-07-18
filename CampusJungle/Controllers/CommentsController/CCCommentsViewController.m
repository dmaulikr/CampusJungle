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
#import "CCCommentsApiProviderProtocol.h"
#import "CCCommentCell.h"
#import "CCAlertHelper.h"
#import "CCStandardErrorHandler.h"

@interface CCCommentsViewController () <CCCommentCellDelegate>

@property (nonatomic, strong) CCAnswerHeader *tableHeaderView;
@property (nonatomic, strong) CCAnswer *answer;
@property (nonatomic, strong) CCCommentsDataProvider *dataProvider;
@property (nonatomic, strong) CCBaseReverseDataSource *dataSource;
@property (nonatomic, strong) id<CCCommentsApiProviderProtocol> ioc_commentsApiProvider;

@end

@implementation CCCommentsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupTableView];
    [self addObservers];

    self.navigationItem.rightBarButtonItem = [CCNavigationBarViewHelper plusButtonWithTarget:self action:@selector(addCommentButtonDidPressed:)];
    [self setTitle:@"Comments"];
}

- (void)dealloc
{
    [self removeObservers];
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

- (void)addObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadComments:) name:CCNotificationsNames.reloadComments object:nil];
}

- (void)removeObservers
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CCNotificationsNames.reloadComments object:nil];
}

#pragma mark -
#pragma mark Actions
- (void)addCommentButtonDidPressed:(id)sender
{
    [self.addCommentTransaction performWithObject:self.answer];
}

- (void)reloadComments:(id)sender
{
    [self.dataProvider loadItems];
}

#pragma mark -
#pragma mark CCCommentCellDelegate
- (void)deleteComment:(CCComment *)comment
{
    __weak CCCommentsViewController *weakSelf = self;
    [CCAlertHelper showConfirmWithSuccess:^{
        [weakSelf.ioc_commentsApiProvider deleteComment:comment successHandler:^(RKMappingResult *result) {
            [[NSNotificationCenter defaultCenter] postNotificationName:CCNotificationsNames.reloadAnswers object:nil];
            [SVProgressHUD showSuccessWithStatus:CCSuccessMessages.deleteComment duration:CCProgressHudsConstants.loaderDuration];
            [weakSelf.dataProvider deleteItem:comment];
        } errorHandler:^(NSError *error) {
            [CCStandardErrorHandler showErrorWithError:error];
        }];
    }];
}

@end
