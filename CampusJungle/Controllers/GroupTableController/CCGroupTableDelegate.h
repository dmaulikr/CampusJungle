//
//  CCGroupTableDelegate.h
//  CampusJungle
//
//  Created by Yury Grinenko on 09.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CCUser, CCLocation, CCForum, CCMessage;

@protocol CCGroupTableDelegate <NSObject>

- (void)showProfileOfUser:(CCUser *)user;
- (void)showLocation:(CCLocation *)location onMapWithLocations:(NSArray *)locationsArray;
- (void)showDetailsOfForum:(CCForum *)forum;
- (void)showDetailsOfGroupMessage:(CCMessage *)message;
- (void)addLocation;
- (void)addForum;
- (void)addGroupmates;
- (void)sendGroupMessage;

@end
