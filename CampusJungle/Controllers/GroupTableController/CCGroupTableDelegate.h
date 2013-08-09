//
//  CCGroupTableDelegate.h
//  CampusJungle
//
//  Created by Yury Grinenko on 09.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CCUser, CCLocation, CCQuestion, CCMessage;

@protocol CCGroupTableDelegate <NSObject>

- (void)showProfileOfUser:(CCUser *)user;
- (void)showLocation:(CCLocation *)location onMapWithLocations:(NSArray *)locationsArray;
- (void)showDetailsOfQuestion:(CCQuestion *)question;
- (void)showDetailsOfGroupMessage:(CCMessage *)message;
- (void)addLocation;
- (void)addQuestion;
- (void)addGroupmates;
- (void)sendGroupMessage;
- (void)viewAttachmentOfQuestion:(CCQuestion *)question;

@end
