//
//  CCSignUpTransaction.h
//  CollegeConnect
//
//  Created by Vlad Korzun on 22.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTransaction.h"

@interface CCSignUpTransaction : NSObject<CCTransaction>

@property (nonatomic, weak) UINavigationController *navigation;

@property (nonatomic, strong) id <CCTransaction> initialUserProfileTransaction;

@end
