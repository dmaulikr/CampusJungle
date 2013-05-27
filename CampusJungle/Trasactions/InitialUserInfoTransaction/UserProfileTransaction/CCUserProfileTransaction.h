//
//  CCUserProfileTransaction.h
//  CollegeConnect
//
//  Created by Vlad Korzun on 24.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCMenuController.h"
#import "CCTransaction.h"

@interface CCUserProfileTransaction : NSObject<CCTransaction>

@property (nonatomic, strong) CCMenuController *menuController;

@end
