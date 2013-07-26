//
//  CCAddressBookRecord.h
//  CampusJungle
//
//  Created by Yury Grinenko on 17.08.12.
//  Copyright (c) 2013 111Minutes. All rights reserved.
//

@interface CCAddressBookRecord : NSObject

@property (nonatomic, assign) NSInteger recordId;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSArray *phoneNumbers;
@property (nonatomic, strong) NSArray *emails;

@property (nonatomic, strong) NSMutableArray *checkedEmails;
@property (nonatomic, strong) NSMutableArray *checkedPhoneNumbers;

@property (nonatomic, strong) NSString *firstNameSearchString;
@property (nonatomic, strong) NSString *lastNameSearchString;

@property (nonatomic, assign) BOOL checked;

- (id)initWithABRecordRef:(ABRecordRef)record;
- (NSArray *)selectedCredentials;

@end
