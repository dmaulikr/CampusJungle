//
//  CCShowLocationsTransaction.h
//  CampusJungle
//
//  Created by Yury Grinenko on 09.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTransactionWithObject.h"

@interface CCShowLocationsTransaction : NSObject <CCTransactionWithObject>

@property (nonatomic, strong) UINavigationController *navigation;

@end
