//
//  CCAddressBookService.m
//  CampusJungle
//
//  Created by Yury Grinenko on 11.12.12.
//  Copyright (c) 2012 111Minutes. All rights reserved.
//

#import "CCAddressBookService.h"
#import "CCAddressBookRecord.h"

@implementation CCAddressBookService

+ (BOOL)isAddressBookEmpty {
    return [[self addressBookArray] count] == 0;
}

+ (NSArray *)addressBookArray {
    __block BOOL accessed = NO;
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined) {
        ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, NULL);
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
            ABAddressBookRequestAccessWithCompletion(addressBookRef, ^(bool granted, CFErrorRef error) {
            accessed = granted;
             dispatch_semaphore_signal(sema);
        });
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        CFRelease(addressBookRef);
    }
    else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized) {
        accessed = YES;
    }
    if (accessed) {
        return [self addressBookRecords];
    }
    else {
        [SVProgressHUD showErrorWithStatus:CCAlertsMessages.unableToImportContacts duration:CCProgressHudsConstants.loaderDuration];
        return [NSArray array];
    }
}

+ (NSArray *)addressBookRecords {
    NSMutableArray *addressBookRecords = [NSMutableArray new];
    ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, NULL);
    
    CFArrayRef people = ABAddressBookCopyArrayOfAllPeople(addressBookRef);
    CFMutableArrayRef peopleMutable = CFArrayCreateMutableCopy(kCFAllocatorDefault, CFArrayGetCount(people), people);
    CFRelease(people);
    CFArraySortValues(peopleMutable, CFRangeMake(0, CFArrayGetCount(peopleMutable)), (CFComparatorFunction) ABPersonComparePeopleByName, (void *)ABPersonGetSortOrdering());
    if (peopleMutable){
        NSInteger numberOfPersonsInAB = CFArrayGetCount(peopleMutable);
        for (int i = 0; i < numberOfPersonsInAB; i++) {
            ABRecordRef recordRef = CFArrayGetValueAtIndex(peopleMutable, i);
            CCAddressBookRecord *record = [[CCAddressBookRecord alloc] initWithABRecordRef:recordRef];
            [addressBookRecords addObject:record];
        }
        CFRelease(peopleMutable);
        CFRelease(addressBookRef);
        return addressBookRecords;
    }
    else {
        CFRelease(addressBookRef);
        return [NSArray array];
    }
}

@end
