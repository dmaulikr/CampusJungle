//
//  CCAppInvite.h
//  CampusJungle
//
//  Created by Yury Grinenko on 26.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCRestKitMappableModel.h"

@class CCAddressBookRecord;

@interface CCAppInvite : NSObject <CCRestKitMappableModel>

@property (nonatomic, strong) NSString *appInviteid;
@property (nonatomic, strong) NSString *senderId;
@property (nonatomic, strong) NSString *recipientEmail;
@property (nonatomic, strong) NSString *recipientPhoneNumber;
@property (nonatomic, strong) NSString *recipientFirstName;
@property (nonatomic, strong) NSString *recipientLastName;
@property (nonatomic, strong) NSString *recipientFacebookUid;
@property (nonatomic, strong) NSString *recipientTwitterUid;
@property (nonatomic, strong) NSDate *updatedDate;

+ (CCAppInvite *)createWithAddressBookRecord:(CCAddressBookRecord *)record;

@end
