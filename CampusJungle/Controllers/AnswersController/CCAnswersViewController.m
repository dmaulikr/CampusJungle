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

#import "CCAnswersDataSource.h"
#import "CCAnswersDataProvider.h"
#import "CCAnswersApiProviderProtocol.h"
#import "CCAnswerCell.h"
#import "CCQuestionHeaderView.h"

#import "CCAlertHelper.h"
#import "CCStandardErrorHandler.h"

@interface CCAnswersViewController () <CCAnswerCellDelegate>

@property (nonatomic, strong) CCQuestion *question;
@property (nonatomic, strong) CCAnswersDataProvider *dataProvider;
@property (nonatomic, strong) CCAnswersDataSource *dataSource;
@property (nonatomic, strong) id<CCAnswersApiProviderProtocol> ioc_answersApiProvider;
@property (nonatomic, strong) CCQuestionHeaderView *tableHeaderView;

@end

@implementation CCAnswersViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupTableView];
    
    [self setTitle:@"Answers"];
    self.navigationItem.rightBarButtonItem = [CCNavigationBarViewHelper plusButtonWithTarget:self action:@selector(addAnswerButtonDidPressed:)];
}

- (void)setupTableView
{
    self.tableHeaderView = [[CCQuestionHeaderView alloc] initWithQuestionText:self.question.text];
    self.mainTable.tableHeaderView = self.tableHeaderView;
    
    self.dataSource = [CCAnswersDataSource new];
    self.dataSource.delegate = self;
    
    self.dataProvider = [CCAnswersDataProvider new];
    self.dataProvider.questionId = self.question.questionId;
    [self configTableWithProvider:self.dataProvider cellClass:[CCAnswerCell class]];
}

#pragma mark -
#pragma mark Actions
- (BOOL)isNeedToLeftSelected
{
    return NO;
}

- (void)didSelectedCellWithObject:(id)cellObject
{
    // go comments
}

- (void)addAnswerButtonDidPressed:(id)sender
{
    
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

@end
