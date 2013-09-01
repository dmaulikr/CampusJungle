//
//  CCDialogsAPIProviderProtocol.h
//  CampusJungle
//
//  Created by Vlad Korzun on 16.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CCDialogsAPIProviderProtocol <NSObject>

- (void)loadMyDialogsPageNumber:(NSInteger)pageNumber successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;
- (void)loadDialogWithUser:(NSString *)userID SuccessHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;
- (void)loadMessagesForDialogWithID:(NSString *)dialogID DialogsPageNumber:(NSInteger)pageNumber successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;

- (void)loadDialogWithID:(NSString *)dialogID SuccessHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;

- (void)loadDialogForGroupWithID:(NSString *)groupID SuccessHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;

@end
