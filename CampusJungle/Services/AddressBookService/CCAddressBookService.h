//
//  CCAddressBookService.h
//  CampusJungle
//
//  Created by Yury Grinenko on 11.12.12.
//  Copyright (c) 2012 111Minutes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCAddressBookService : NSObject

+ (BOOL)isAddressBookEmpty;
+ (NSArray *)addressBookArray;

@end
