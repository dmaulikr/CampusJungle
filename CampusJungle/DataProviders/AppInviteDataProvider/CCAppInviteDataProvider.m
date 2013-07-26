//
//  CCEmailInviteDataProvider.m
//  CampusJungle
//
//  Created by Yury Grinenko on 26.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAppInviteDataProvider.h"
#import "CCAddressBookRecord.h"
#import "CCAddressBookService.h"

typedef enum {
    kEmailMode = 0,
    kSMSMode = 1,
} InviteMode;

@interface CCAppInviteDataProvider ()

@property (nonatomic, strong) NSArray *addressBookRecords;
@property (nonatomic, strong) NSArray *filteredAddressBookRecords;

@end

@implementation CCAppInviteDataProvider

- (void)loadItems
{
    [self.targetTable reloadData];
}

- (void)setMode:(NSInteger)mode
{
    _mode = mode;
    [self getAddressBook];
}

#pragma mark -
#pragma mark Actions
- (NSArray *)checkedCredentials
{
    NSMutableArray *checkedCredentials = [NSMutableArray array];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"checked == YES"];
    for (NSArray *recordsArray in self.addressBookRecordsWithSections) {
        NSArray *checkedRecords = [recordsArray filteredArrayUsingPredicate:predicate];
        for (CCAddressBookRecord *record in checkedRecords) {
            [checkedCredentials addObjectsFromArray:[record selectedCredentials]];
        }
    }
    return checkedCredentials;
}

- (NSArray *)checkedRecords
{
    NSMutableArray *resultRecordsArray = [NSMutableArray array];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"checked == YES"];
    for (NSArray *recordsArray in self.addressBookRecordsWithSections) {
        NSArray *checkedRecords = [recordsArray filteredArrayUsingPredicate:predicate];
        [resultRecordsArray addObjectsFromArray:checkedRecords];
    }
    return resultRecordsArray;
}

#pragma mark -
#pragma mark Work with AddressBook
- (void)getAddressBook {
    self.addressBookRecords = [CCAddressBookService addressBookArray];
    if ([self.addressBookRecords count] > 0) {
        [self generateAddressBookWithSection];
    }
    else {
        self.firstLetters = [NSMutableArray array];
        self.addressBookRecordsWithSections = [NSMutableArray array];
        self.filteredAddressBookRecords = [NSMutableArray array];
    }
}

- (void)filterRecordsWithoutEmailOrPhoneNumber {
    NSMutableArray *selectableRecordsArray = [NSMutableArray array];
    for (CCAddressBookRecord *record in self.addressBookRecords) {
        if ([self isSelectableRecord:record]) {
            [selectableRecordsArray addObject:record];
        }
    }
    self.addressBookRecords = [NSArray arrayWithArray:selectableRecordsArray];
}

- (BOOL)isSelectableRecord:(CCAddressBookRecord *)record {
    if (self.mode == kEmailMode) {
        return ([record.emails count] > 0);
    }
    return ([record.phoneNumbers count] > 0);
}

- (BOOL)hasEmailsRecord:(CCAddressBookRecord *)record
{
    return ([record.emails count] > 0);
}

- (BOOL)hasPhoneNumbersRecord:(CCAddressBookRecord *)record
{
    return ([record.phoneNumbers count] > 0);
}

- (void)generateAddressBookWithSection {
    [self filterRecordsWithoutEmailOrPhoneNumber];
    [self createFirstLettersArray];
    [self createLettersSectionsArrays];
    self.filteredAddressBookRecords = [self.addressBookRecordsWithSections copy];
}

- (void)createFirstLettersArray {
    self.firstLetters = [NSMutableArray new];
    
    for (CCAddressBookRecord *record in self.addressBookRecords) {
        NSString *firstLetter = [self firstLetterOfRecord:record];
        if ([firstLetter length] == 0) {
            continue;
        }
        BOOL needAdded = YES;
        if (firstLetter) {
            for (NSString *letter in self.firstLetters) {
                if ([letter isEqualToString:firstLetter]) {
                    needAdded = NO;
                    break;
                }
            }
        }
        if (needAdded && firstLetter) {
            [self.firstLetters addObject:firstLetter];
        }
    }
    self.firstLetters = (NSMutableArray *)[self.firstLetters sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}

- (void)createLettersSectionsArrays {
    self.addressBookRecordsWithSections = [NSMutableArray new];
    for (NSString *letter in self.firstLetters) {
        NSMutableArray *someSection = [NSMutableArray new];
        for (CCAddressBookRecord *record in self.addressBookRecords) {
            if ([record.lastName length] > 0) {
                NSString *tempString = [[NSString stringWithString:record.lastName] uppercaseString];
                if ([tempString characterAtIndex:0] == [letter characterAtIndex:0]) {
                    [someSection addObject:record];
                }
            }
            else if ([record.firstName length] > 0) {
                NSString *tempString = [[NSString stringWithString:record.firstName] uppercaseString];
                if ([tempString characterAtIndex:0] == [letter characterAtIndex:0]) {
                    [someSection addObject:record];
                }
            }
        }
        [self.addressBookRecordsWithSections addObject:someSection];
    }
}

- (NSString *)firstLetterOfRecord:(CCAddressBookRecord *)record {
    NSString *nameString;
    if ([record.lastName length] > 0) {
        nameString = record.lastName;
    }
    else if ([record.firstName length] > 0) {
        nameString = record.firstName;
    }
    return [[nameString substringToIndex:1] uppercaseString];
}

@end
