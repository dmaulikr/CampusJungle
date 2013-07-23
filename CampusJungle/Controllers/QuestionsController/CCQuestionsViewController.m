//
//  CCQuestionsViewController.m
//  CampusJungle
//
//  Created by Yury Grinenko on 15.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCQuestionsViewController.h"
#import "CCNavigationBarViewHelper.h"
#import "CCQuestionsDataProvider.h"
#import "CCQuestionsApiProviderProtocol.h"
#import "CCStandardErrorHandler.h"

#import "CCForum.h"
#import "CCAlertHelper.h"
#import "CCQuestionCell.h"

@interface CCQuestionsViewController () <CCQuestionCellDelegate>

@property (nonatomic, weak) IBOutlet UILabel *forumDescriptionLabel;

@property (nonatomic, strong) id<CCQuestionsApiProviderProtocol> ioc_questionsApiProvider;
@property (nonatomic, strong) CCQuestionsDataProvider *dataProvider;
@property (nonatomic, strong) CCForum *forum;

@end

@implementation CCQuestionsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupLabels];
    [self setupTableView];
    
    [self setTitle:self.forum.name];
    self.navigationItem.rightBarButtonItem = [CCNavigationBarViewHelper plusButtonWithTarget:self action:@selector(addQuestionButtonDidPressed:)];
    [(UIScrollView *)self.view setScrollEnabled:NO];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.dataProvider loadItems];
}

- (void)setupLabels
{
    [self.forumDescriptionLabel setText:self.forum.description];
}

- (void)setupTableView
{
    self.dataProvider = [CCQuestionsDataProvider new];
    self.dataProvider.delegate = self;
    [self.dataProvider setForumId:self.forum.forumId];
    [self configTableWithProvider:self.dataProvider cellClass:[CCQuestionCell class]];
}

#pragma mark -
#pragma mark Actions
- (void)addQuestionButtonDidPressed:(id)sender
{
    [self.addQuestionTransaction performWithObject:self.forum];
}

#pragma mark -
#pragma mark TableView callbacks
- (BOOL)isNeedToLeftSelected
{
    return NO;
}

- (void)didSelectedCellWithObject:(CCQuestion *)question
{
    if (![question uploadProgress]) {
        [self.answersTransaction performWithObject:question];
    }
}

#pragma mark -
#pragma mark CCQuestionCellDelegate
- (void)deleteQuestion:(CCQuestion *)question
{
    __weak CCQuestionsViewController *weakSelf = self;
    [CCAlertHelper showConfirmWithSuccess:^{
        [self.ioc_questionsApiProvider deleteQuestion:question successHandler:^(RKMappingResult *object) {
            [SVProgressHUD showSuccessWithStatus:CCSuccessMessages.deleteQuestion duration:CCProgressHudsConstants.loaderDuration];
            [weakSelf.dataProvider deleteItem:question];
        } errorHandler:^(NSError *error) {
            [CCStandardErrorHandler showErrorWithError:error];
        }];
    }];
}

- (void)emailAttachmentOfQuestion:(CCQuestion *)question
{
    [self.ioc_questionsApiProvider emailAttachmentOfQuestion:question successHandler:^(id object) {
        [SVProgressHUD showSuccessWithStatus:CCSuccessMessages.questionAttachmentEmailed duration:CCProgressHudsConstants.loaderDuration];
    } errorHandler:^(NSError *error) {
        [CCStandardErrorHandler showErrorWithError:error];
    }];
}

- (void)viewAttachmentOfQuestion:(CCQuestion *)question
{
    [self.viewQuestionAttachmentTransaction performWithObject:question.attachment];
}

@end
