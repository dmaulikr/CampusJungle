//
//  CCLocationsViewController.h
//  CampusJungle
//
//  Created by Yury Grinenko on 09.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCTableBaseViewController.h"
#import "CCTransactionWithObject.h"

@class CCLocation, CCClass, CCGroup;

@interface CCLocationsViewController : CCTableBaseViewController

@property (nonatomic, strong) id <CCTransactionWithObject> addLocationTransaction;

- (id)initWithLocationsArray:(NSArray *)locationsArray;
- (void)setSelectedLocation:(CCLocation *)selectedLocation;
- (void)setSearchString:(NSString *)searchString;
- (void)setClass:(CCClass *)classObject;
- (void)setGroup:(CCGroup *)group;

@end
