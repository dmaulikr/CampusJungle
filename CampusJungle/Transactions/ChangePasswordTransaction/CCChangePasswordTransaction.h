//
//  CCChangePasswordTransaction.h
//  CampusJungle
//
//  Created by Yury Grinenko on 06.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTransaction.h"

@interface CCChangePasswordTransaction : NSObject <CCTransaction>

@property (nonatomic, strong) UINavigationController *navigation;

@end
