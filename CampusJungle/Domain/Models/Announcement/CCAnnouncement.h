//
//  CCAnouncement.h
//  CampusJungle
//
//  Created by Vlad Korzun on 22.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCRestKitMappableModel.h"

@interface CCAnnouncement : NSObject<CCRestKitMappableModel>

@property (nonatomic, strong) NSString *topic;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *ownerId;
@property (nonatomic, strong) NSString *ownerFirstName;
@property (nonatomic, strong) NSString *ownerLastName;
@property (nonatomic, strong) NSString *announcementID;
@property (nonatomic, strong) NSDate *createdDate;
@property (nonatomic, strong) NSString *classID;

@end
