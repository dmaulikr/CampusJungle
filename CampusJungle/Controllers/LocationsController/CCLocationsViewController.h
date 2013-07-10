//
//  CCLocationsViewController.h
//  CampusJungle
//
//  Created by Yury Grinenko on 09.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCTableBasedController.h"

@class CCLocation;

@interface CCLocationsViewController : CCTableBasedController

- (id)initWithLocationsArray:(NSArray *)locationsArray;
- (void)setSelectedLocation:(CCLocation *)selectedLocation;
- (void)setClassId:(NSString *)classId;

@end
