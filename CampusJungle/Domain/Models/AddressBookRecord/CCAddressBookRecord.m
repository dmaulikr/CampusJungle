//
//  CCAddressBookRecord.m
//  CampusJungle
//
//  Created by Yury Grinenko on 17.08.12.
//  Copyright (c) 2013 111Minutes. All rights reserved.
//

#import "CCAddressBookRecord.h"
#import "CCAddressBookHelper.h"

@implementation CCAddressBookRecord

- (id)initWithABRecordRef:(ABRecordRef)record {
    self = [super init];
    if (self) {
        self.firstName = [CCAddressBookHelper firstNameFromRecord:record];
        self.lastName = [CCAddressBookHelper lastNameFromRecord:record];
        
        self.recordId = ABRecordGetRecordID(record);
        self.emails = [CCAddressBookHelper emailsFromRecord:record];
        self.phoneNumbers = [CCAddressBookHelper phoneNumbersFromRecord:record];
        
        self.firstNameSearchString = [CCAddressBookHelper firstNameSearchStringForRecord:record];
        self.lastNameSearchString = [CCAddressBookHelper lastNameSearchStringForRecord:record];
        
        self.checkedEmails = [NSMutableArray array];
        self.checkedPhoneNumbers = [NSMutableArray array];
        
        [self fillMandatoryFields];
    }
    return self;
}

- (NSArray *)selectedCredentials
{
    if ([self.checkedEmails count] > 0) {
        return self.checkedEmails;
    }
    return self.checkedPhoneNumbers;
}

- (void)fillMandatoryFields {
    if ([self.firstName length] == 0 && [self.lastName length] == 0) {
        NSString *validCredential = [self validEmailOrPhone];
        self.firstName = validCredential;
        self.firstNameSearchString = validCredential;
        self.lastNameSearchString = validCredential;
    }
}

- (NSString *)validEmailOrPhone {
    if ([self.emails count] > 0) {
        return [self.emails objectAtIndex:0];
    }
    if ([self.phoneNumbers count] > 0) {
        return [self.phoneNumbers objectAtIndex:0];
    }
    return @"";
}

@end
