//
//  CCAddressBookRecordCell.h
//  CampusJungle
//
//  Created by Yury Grinenko on 26.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCBaseCell.h"

#import "CCAddressBookRecord.h"

@interface CCAddressBookRecordCell : CCBaseCell

- (void)setCellObject:(CCAddressBookRecord *)record;
- (void)userTapsToSelectEmails;
- (void)userTapsToSelectPhoneNumbers;

@end
