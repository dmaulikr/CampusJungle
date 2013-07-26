//
//  CCAppInvite.h
//  CampusJungle
//
//  Created by Yury Grinenko on 26.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCRestKitMappableModel.h"

@interface CCAppInvite : NSObject <CCRestKitMappableModel>

@property (nonatomic, strong) NSString *appInviteid;
@property (nonatomic, strong) NSString *senderId;
@property (nonatomic, strong) NSString *recepientEmail;
@property (nonatomic, strong) NSString *recepientPhoneNumber;
@property (nonatomic, strong) NSString *recepientFirstName;
@property (nonatomic, strong) NSString *recepientLastName;
@property (nonatomic, strong) NSString *recepientFacebookUid;
@property (nonatomic, strong) NSString *recepientTwitterUid;
@property (nonatomic, strong) NSDate *updatedDate;

@end
