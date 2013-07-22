//
//  CCAnnouncementAPIProviderProtocol.h
//  CampusJungle
//
//  Created by Vlad Korzun on 22.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCAnnouncement.h"
#import "CCTypesDefinition.h"

@protocol CCAnnouncementAPIProviderProtocol <AppleGuiceInjectable>

- (void)loadAnnouncementsClassID:(NSString *)classID filterString:(NSString *)filterString pageNumber:(NSInteger)pageNumber successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;

- (void)postAnnouncement:(CCAnnouncement *)announcement successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler;

- (void)deleteAnnouncement:(CCAnnouncement *)announcement successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler;


@end
