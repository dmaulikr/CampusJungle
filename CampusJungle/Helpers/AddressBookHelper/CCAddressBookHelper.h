//
//  CCAddressBookHelper.h
//  CampusJungle
//
//  Created by Yury Grinenko on 17.08.12.
//  Copyright (c) 2013 111Minutes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCAddressBookHelper : NSObject

+ (NSString *)firstNameFromRecord:(ABRecordRef)record;
+ (NSString *)lastNameFromRecord:(ABRecordRef)record;
+ (NSArray *)emailsFromRecord:(ABRecordRef)record;
+ (NSArray *)phoneNumbersFromRecord:(ABRecordRef)record;
+ (NSString *)firstNameSearchStringForRecord:(ABRecordRef)record;
+ (NSString *)lastNameSearchStringForRecord:(ABRecordRef)record;

@end
