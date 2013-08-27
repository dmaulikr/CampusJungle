//
//  CCChatController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 12.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCChatController.h"
#import "CCUserSessionProtocol.h"
#import "CCChatDataSource.h"
#import "CCMessageAPIProviderProtocol.h"
#import "CCStandardErrorHandler.h"
#import "MBProgressHUD+Status.h"

@interface CCChatController ()<AMBubbleTableDelegate>

@property (nonatomic, strong) NSMutableArray* data;
@property (nonatomic, strong) id <CCUserSessionProtocol> ioc_userSession;
@property (nonatomic, strong) id <CCMessageAPIProviderProtocol> ioc_messageAPIProvider;
@property (nonatomic, strong) id <CCAPIProviderProtocol> ioc_apiProvider;
@property (nonatomic, strong) CCChatDataSource *chatDataSource;
@property (nonatomic) BOOL isFirstLoading;
@property (nonatomic) CGFloat contentSizeBeforeLoading;

@end

@implementation CCChatController

- (void)viewDidAppear:(BOOL)animated
{
    self.chatDataSource = [CCChatDataSource new];
    self.chatDataSource.chatDataProvider = [CCChatDataProvider new];
    self.chatDataSource.chatDataProvider.chatID = self.dialog.dialogID;
    
    self.chatDataSource.chatDataProvider.targetTable = (UITableView *)self;
    self.isFirstLoading = YES;
    [self setDataSource:self.chatDataSource];
	[self setDelegate:self];
    self.data = [@[
                  ] mutableCopy];
    [self setTableStyle:AMBubbleTableStyleSquare];
    [super viewDidAppear:YES];
    [(CCPaginationDataProvider *)self.chatDataSource.chatDataProvider setBeforeLoadingFilter:^{
        [MBProgressHUD showInKeyWindowWithStatus:nil];
    }];
    [(CCPaginationDataProvider *)self.chatDataSource.chatDataProvider setAfterLoadingFilter:^{
        [MBProgressHUD hideInKeyWindow];
        [super reloadTableScrollingToBottom:YES];
        
    }];
    [self.chatDataSource.chatDataProvider loadItems];
}

- (NSString *)title
{
    return @"Chat";
}

- (void)reloadData
{
    if(self.isFirstLoading){
        [super reloadTableScrollingToBottomWitoutAnimation];
        self.isFirstLoading = NO;
    } else {
        [super reloadTableScrollingToBottom:NO];
        CGFloat offset = self.tableView.contentSize.height - self.contentSizeBeforeLoading;

        [self.tableView setContentOffset:CGPointMake(0, offset) animated:NO];
    }
}

- (void)didSendText:(NSString*)text
{
    [self.ioc_messageAPIProvider sendMessage:text
                                      toUser:self.dialog.interlocutor.uid
                                    dialogID:self.dialog.dialogID
                              successHandler:^(RKMappingResult *result) {
                                  self.isFirstLoading = YES;
                                  [self.chatDataSource.chatDataProvider loadItems];
                                }
                                errorHandler:^(NSError *error) {
                                    [CCStandardErrorHandler showErrorWithError:error];
                                }];
    
	[super reloadTableScrollingToBottom:NO];
}

- (void)loadNewMessages
{
    [self.chatDataSource.chatDataProvider loadItems];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView.contentOffset.y < 100){
        self.contentSizeBeforeLoading = self.tableView.contentSize.height;
        [self.chatDataSource.chatDataProvider loadMoreItems];
    }
    self.contentSizeBeforeLoading = self.tableView.contentSize.height;
    
}

- (void)didSelectCellWithInxex:(NSInteger)index
{
    CCMessage * currentObject = self.chatDataSource.formatedArrayOfMessages[index];
    if(![currentObject isKindOfClass: [CCMessage class]]) return;
    if(currentObject.receiverID.intValue == [[[self.ioc_userSession currentUser] uid] intValue]){
        [self.ioc_apiProvider getUserWithID:currentObject.senderID
                             successHandler:^(RKMappingResult *result) {
            [self.otherUserProfileTransaction performWithObject:result.firstObject];
        }
                               errorHandler:^(NSError *error) {
            [CCStandardErrorHandler showErrorWithError:error];
        }];
    }
}

@end
