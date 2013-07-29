//
//  CCPushProcessingProtocol.h
//  CampusJungle
//
//  Created by Yury Grinenko on 29.07.13.
//  Copyright (c) 2013 111Minutes. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CCPushProcessingProtocol <NSObject>

@required
- (void)processWhenAppNotRunningWithUserInfo:(NSDictionary *)userInfo;
- (void)processWhenAppInBackgroundWithUserInfo:(NSDictionary *)userInfo;
- (void)processWhenAppActiveWithUserInfo:(NSDictionary *)userInfo;

@end
