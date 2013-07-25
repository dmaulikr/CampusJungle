//
//  CCGroupInvite.h
//  CampusJungle
//
//  Created by Yury Grinenko on 24.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCRestKitMappableModel.h"

@interface CCGroupInvite : NSObject <CCRestKitMappableModel>

@property (nonatomic, strong) NSString *groupInviteId;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSDate *updatedDate;
@property (nonatomic, strong) NSString *senderId;
@property (nonatomic, strong) NSString *recepientId;

@property (nonatomic, strong) NSString *groupName;
@property (nonatomic, strong) NSString *groupDescription;

@property (nonatomic, strong) NSString *senderFirstName;
@property (nonatomic, strong) NSString *senderLastName;
@property (nonatomic, strong) NSString *senderAvatar;

@end
