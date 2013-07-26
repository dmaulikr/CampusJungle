//
//  CCAddressBookHelper.m
//  CampusJungle
//
//  Created by Yury Grinenko on 17.08.12.
//  Copyright (c) 2013 111Minutes. All rights reserved.//

#import "CCAddressBookHelper.h"

@implementation CCAddressBookHelper

+ (NSString *)firstNameFromRecord:(ABRecordRef)record {
    return (__bridge_transfer NSString *)ABRecordCopyValue(record, kABPersonFirstNameProperty) ? (__bridge_transfer NSString *)ABRecordCopyValue(record, kABPersonFirstNameProperty) : @"";
}

+ (NSString *)lastNameFromRecord:(ABRecordRef)record {
    return (__bridge_transfer NSString *)ABRecordCopyValue(record, kABPersonLastNameProperty) ? (__bridge_transfer NSString *)ABRecordCopyValue(record, kABPersonLastNameProperty) : @"";
}

+ (NSArray *)emailsFromRecord:(ABRecordRef)record {
    NSMutableArray *resultArray = [NSMutableArray array];
    ABMultiValueRef emails = (ABMultiValueRef)ABRecordCopyValue(record, kABPersonEmailProperty);
    for (CFIndex i = 0; i < ABMultiValueGetCount(emails); i++) {
        NSString *email = (__bridge_transfer NSString *)ABMultiValueCopyValueAtIndex(emails, i);
        [resultArray addObject:email];
    }
    CFRelease(emails);
    return resultArray;
}

+ (NSArray *)phoneNumbersFromRecord:(ABRecordRef)record {
    NSMutableArray *resultArray = [NSMutableArray array];
    ABMultiValueRef phoneNumbers = (ABMultiValueRef)ABRecordCopyValue(record, kABPersonPhoneProperty);
    for (CFIndex i = 0; i < ABMultiValueGetCount(phoneNumbers); i++) {
        NSString *phoneNumber = (__bridge_transfer NSString *)ABMultiValueCopyValueAtIndex(phoneNumbers, i);
        [resultArray addObject:[self clearPhoneNumberFromString:phoneNumber]];
    }
    CFRelease(phoneNumbers);
    return resultArray;
}

+ (NSString *)clearPhoneNumberFromString:(NSString *)string {
    NSString *returnString = [string stringByReplacingOccurrencesOfString:@"(" withString:@""];
    returnString = [returnString stringByReplacingOccurrencesOfString:@")" withString:@""];
    returnString = [returnString stringByReplacingOccurrencesOfString:@"-" withString:@""];
    returnString = [returnString stringByReplacingOccurrencesOfString:@" " withString:@""];
    return returnString;
}

+ (NSString *)firstNameSearchStringForRecord:(ABRecordRef)record {
    NSString *firstName = [self firstNameFromRecord:record];
    NSString *lastName = [self lastNameFromRecord:record];
    
    return [self stringWithNonNilParts:firstName second:lastName];
}

+ (NSString *)lastNameSearchStringForRecord:(ABRecordRef)record {
    NSString *firstName = [self firstNameFromRecord:record];
    NSString *lastName = [self lastNameFromRecord:record];
    
    return [self stringWithNonNilParts:lastName second:firstName];
}

+ (NSString *)stringWithNonNilParts:(NSString *)firstPart second:(NSString *)secondPart {
    if ([firstPart length] > 0 && [secondPart length] > 0) {
        return [NSString stringWithFormat:@"%@ %@", firstPart, secondPart];
    }
    else {
        return ([firstPart length] > 0) ? firstPart : secondPart;
    }
}

@end
