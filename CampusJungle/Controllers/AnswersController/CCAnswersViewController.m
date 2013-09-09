//
//  CCAnswersViewController.m
//  CampusJungle
//
//  Created by Yury Grinenko on 16.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAnswersViewController.h"
#import "CCNavigationBarViewHelper.h"
#import "CCQuestion.h"

#import "CCBaseReverseDataSource.h"
#import "CCAnswersDataProvider.h"
#import "CCAnswersApiProviderProtocol.h"
#import "CCAnswerCell.h"
#import "CCQuestionHeaderView.h"

#import "CCAlertHelper.h"
#import "CCStandardErrorHandler.h"
#import "CCAnswer.h"

@interface CCAnswersViewController () <CCAnswerCellDelegate>

@property (nonatomic, strong) CCQuestion *question;
@property (nonatomic, strong) CCAnswersDataProvider *dataProvider;
@property (nonatomic, strong) CCBaseReverseDataSource *dataSource;
@property (nonatomic, strong) id<CCAnswersApiProviderProtocol> ioc_answersApiProvider;
@property (nonatomic, strong) CCQuestionHeaderView *tableHeaderView;


@end

@implementation CCAnswersViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupTableView];
    [self addObservers];
    
    [self setTitle:@"Answers"];
    self.navigationItem.rightBarButtonItem = [CCNavigationBarViewHelper plusButtonWithTarget:self action:@selector(addAnswerButtonDidPressed:)];
}

- (void)dealloc
{
    [self removeObservers];
}

- (void)setupTableView
{
    self.tableHeaderView = [[CCQuestionHeaderView alloc] initWithQuestionText:self.question.text subject:self.question.subject bottomDividerVisibile:YES];
    self.mainTable.tableHeaderView = self.tableHeaderView;
    
    self.dataSource = [CCBaseReverseDataSource new];
    self.dataSource.delegate = self;
    
    self.dataProvider = [CCAnswersDataProvider new];
    self.dataProvider.questionId = self.question.questionId;
    [self configTableWithProvider:self.dataProvider cellClass:[CCAnswerCell class]];
}

- (void)addObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadAnswers) name:CCNotificationsNames.reloadAnswers object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadCellWithAnswer:) name:CCNotificationsNames.reloadCellWithAnswer object:nil];
}

- (void)removeObservers
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CCNotificationsNames.reloadAnswers object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CCNotificationsNames.reloadCellWithAnswer object:nil];
}

#pragma mark -
#pragma mark Actions
- (BOOL)isNeedToLeftSelected
{
    return NO;
}

- (void)reloadAnswers
{
    [self.dataProvider loadItems];
}

- (void)didSelectedCellWithObject:(id)cellObject
{
    [self.showCommentsTransaction performWithObject:cellObject];
}

- (void)addAnswerButtonDidPressed:(id)sender
{
    [self.addAnswerTransaction performWithObject:self.question];
}

- (void)reloadCellWithAnswer:(NSNotification *)notification
{
    CCAnswer *answer = [notification.userInfo valueForKey:@"answer"];
    NSInteger answerIndex = [self.dataProvider.arrayOfItems indexOfObject:answer];
    if (answerIndex != NSNotFound) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:answerIndex inSection:0];
        [self.mainTable reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

#pragma mark -
#pragma mark CCAnswerCellDelegate
- (void)deleteAnswer:(CCAnswer *)answer
{
    __weak CCAnswersViewController *weakSelf = self;
    [CCAlertHelper showConfirmWithSuccess:^{
        [weakSelf.ioc_answersApiProvider deleteAnswer:answer successHandler:^(RKMappingResult *result) {
            [SVProgressHUD showSuccessWithStatus:CCSuccessMessages.deleteAnswer duration:CCProgressHudsConstants.loaderDuration];
            [weakSelf.dataProvider deleteItem:answer];
        } errorHandler:^(NSError *error) {
            [CCStandardErrorHandler showErrorWithError:error];
        }];
    }];
}

- (void)likeAnswer:(CCAnswer *)answer successBlock:(RequestSuccessBlock)successBlock
{

    [self.ioc_answersApiProvider likeAnswer:answer successHandler:^(RKMappingResult *result) {
        successBlock();
    } errorHandler:^(NSError *error) {
        [CCStandardErrorHandler showErrorWithError:error];
    }];
}

- (void)viewAttachmentOfAnswer:(CCAnswer *)answer
{
    [self.viewAttacmentTransaction performWithObject:answer.attachment];
}

- (void)emailAttachmentOfAnswer:(CCAnswer *)answer
{
    [self.ioc_answersApiProvider emailAttachmentOfAnswer:answer successHandler:^(id result) {
        [SVProgressHUD showSuccessWithStatus:CCSuccessMessages.answerAttachmentEmailed duration:CCProgressHudsConstants.loaderDuration];
    } errorHandler:^(NSError *error) {
        [CCStandardErrorHandler showErrorWithError:error];
    }];
}

@end
