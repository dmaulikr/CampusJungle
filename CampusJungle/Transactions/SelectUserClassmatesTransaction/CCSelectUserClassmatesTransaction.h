//
//  CCSelectUserClassmatesTransaction.h
//  CampusJungle
//
//  Created by Yury Grinenko on 11.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTransactionWithObject.h"

@interface CCSelectUserClassmatesTransaction : NSObject <CCTransactionWithObject>

@property (nonatomic, weak) UINavigationController *navigation;

@end
