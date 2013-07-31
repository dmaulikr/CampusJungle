//
//  CCPush.h
//  CampusJungle
//
//  Created by Yury Grinenko on 29.07.13.
//  Copyright (c) 2013 111Minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCPushProcessingProtocol.h"

@interface CCPush : NSObject

- (id)initWithUserInfo:(NSDictionary *)userInfo;
- (void)setPushProcessingBehavior:(id<CCPushProcessingProtocol>)pushProccessingBehavior;
- (void)proccessPushNotification;

@end
