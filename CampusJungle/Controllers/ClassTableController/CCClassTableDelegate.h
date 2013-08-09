//
//  CCClassTableDelegate.h
//  CampusJungle
//
//  Created by Yury Grinenko on 09.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CCUser, CCLocation, CCQuestion, CCGroup;

@protocol CCClassTableDelegate <NSObject>

- (void)showProfileOfUser:(CCUser *)user;
- (void)showLocation:(CCLocation *)location onMapWithLocations:(NSArray *)locationsArray;
- (void)showDetailsOfQuestion:(CCQuestion *)question;
- (void)showDetailsOfGroup:(CCGroup *)group;
- (void)sendInvite;
- (void)addLocation;
- (void)addQuestion;
- (void)addGroup;
- (void)viewAttachmentOfQuestion:(CCQuestion *)question;

@end
