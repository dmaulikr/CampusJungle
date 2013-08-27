//
//  CCChatDataProvider.m
//  CampusJungle
//
//  Created by Vlad Korzun on 13.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCChatDataProvider.h"
#import "CCDialogsAPIProviderProtocol.h"

@interface CCChatDataProvider()

@property (nonatomic, strong) id <CCDialogsAPIProviderProtocol> ioc_DialogsAPIProvider;

@end

@implementation CCChatDataProvider

- (void)loadItemsForPageNumber:(long)numberOfPage successHandler:(successWithObject)successHandler
{
    [self.ioc_DialogsAPIProvider loadMessagesForDialogWithID:self.chatID
                                           DialogsPageNumber:(int)numberOfPage
                                              successHandler:^(RKMappingResult *result) {
                                                  successHandler(result.firstObject);
                                              }
                                                errorHandler:^(NSError *error) {
                                                    [self showErrorWhileLoading:error];
                                                }];
}

@end
