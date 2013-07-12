//
//  CCMessage.m
//  CampusJungle
//
//  Created by Vlad Korzun on 10.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCMessage.h"

@implementation CCMessage

+ (NSDictionary *)responseMappingDictionary
{
    return @{
             @"id" : @"messageID",
             @"receiver_id" : @"receiverID",
             @"receiver_type" : @"receiverType",
             @"sender_id" : @"senderID",
             @"text" : @"text",
             @"created_at" : @"createdAt",
             @"user_first_name" : @"userFirstName",
             @"user_last_name" : @"userLastName",
             @"user_avatar_retina" : @"userAvatar",
             };
}

- (NSString *)description
{
    return self.text;
}

- (void)setCreatedAt:(NSDate *)createdAt
{
    _createdAt = createdAt;
    
}

@end
