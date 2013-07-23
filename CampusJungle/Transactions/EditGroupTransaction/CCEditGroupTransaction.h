//
//  CCEditGroupTransaction.h
//  CampusJungle
//
//  Created by Yury Grinenko on 23.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTransactionWithObject.h"

@interface CCEditGroupTransaction : NSObject <CCTransactionWithObject>

@property (nonatomic, strong) UINavigationController *navigation;

@end
