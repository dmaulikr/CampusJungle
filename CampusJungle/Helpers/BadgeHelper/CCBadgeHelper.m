//
//  CCBadgeHelper.m
//  CampusJungle
//
//  Created by Yury Grinenko on 29.07.13.
//  Copyright (c) 2013 111Minutes. All rights reserved.
//

#import "CCBadgeHelper.h"
#import "CCUnwatchedEventsApiProviderProtocol.h"

typedef void(^ResetEventsCounterSuccessBlock)();

@interface CCBadgeHelper ()

@property (nonatomic, strong) id<CCUnwatchedEventsApiProviderProtocol> ioc_unwatchedEventsApiProvider;

@end

@implementation CCBadgeHelper

+ (void)resetApplicationIconBadge
{
    [self resetUnwatchedEventsCounterWithSuccessBlock:^{
         [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    }];
}

+ (void)resetUnwatchedEventsCounterWithSuccessBlock:(ResetEventsCounterSuccessBlock)successBlock
{
    [[CCBadgeHelper new].ioc_unwatchedEventsApiProvider resetUnwatchedEventsCounterWithSuccessHandler:^(id result) {
        successBlock();
        NSLog(@"successfully reseted unwatched events counter");
    } errorHandler:^(NSError *error) {
        NSLog(@"error during reseting unwatched events counter = %@", error);
    }];
}

@end
