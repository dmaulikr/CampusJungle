//
//  CCAPIProviderProtocol.h
//  CampusJungle
//
//  Created by Vlad Korzun on 13.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CCMarketAPIProviderProtocol <AppleGuiceInjectable>

- (void)loadNotesNumberOfPage:(NSNumber *)pageNumber filters:(NSDictionary *)filters order:(NSString *)order query:(NSString *)query successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler;

- (void)performPurchase:(NSString *)noteID fullAccess:(BOOL)fullAccess successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler;

@end
