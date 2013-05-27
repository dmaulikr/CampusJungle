//
//  CCInitialUserInfoTransaction.h
//  CollegeConnect
//
//  Created by Vlad Korzun on 23.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTransaction.h"

@interface CCInitialUserInfoTransaction : NSObject <CCTransaction>

@property (nonatomic, strong) id<CCTransaction> loginTransaction;
@property (nonatomic, strong) UINavigationController *navigation;

@end