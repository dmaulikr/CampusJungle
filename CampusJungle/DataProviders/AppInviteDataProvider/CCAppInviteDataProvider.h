//
//  CCEmailInviteDataProvider.h
//  CampusJungle
//
//  Created by Yury Grinenko on 26.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCBaseDataProvider.h"

@interface CCAppInviteDataProvider : CCBaseDataProvider

@property (nonatomic, strong) NSMutableArray *addressBookRecordsWithSections;
@property (nonatomic, strong) NSMutableArray *firstLetters;
@property (nonatomic, assign) NSInteger mode;

- (void)setMode:(NSInteger)mode;
- (NSArray *)checkedCredentials;
- (NSArray *)checkedRecords;

@end
