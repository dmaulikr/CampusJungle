//
//  CCGroupTransaction.h
//  CampusJungle
//
//  Created by Yury Grinenko on 22.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTransactionWithObject.h"

@interface CCGroupTransaction : NSObject <CCTransactionWithObject>

@property (nonatomic, weak) UINavigationController *navigation;

@end
