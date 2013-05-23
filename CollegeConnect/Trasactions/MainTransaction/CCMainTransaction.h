//
//  CCMainTransaction.h
//  CollegeConnect
//
//  Created by Vlad Korzun on 21.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTransaction.h"

@interface CCMainTransaction : NSObject<CCTransaction>

@property (nonatomic, strong) UIWindow *window;

@end
