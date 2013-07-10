//
//  CCOffer.m
//  CampusJungle
//
//  Created by Vlad Korzun on 08.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCOffer.h"

@implementation CCOffer

+ (NSDictionary *)responseMappingDictionary
{
    return @{
             @"id" : @"offerID",
             @"stuff_id" : @"stuffID",
             @"text" : @"text",
             @"sender_id" : @"senderID",
             @"receiver_id" : @"receiverID",
             };
}

- (NSString *)description
{
    return self.text;
}

@end
