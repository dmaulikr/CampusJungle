//
//  CCLoginTransaction.h
//  CollegeConnect
//
//  Created by Vlad Korzun on 22.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTransaction.h"
#import "CCMenuController.h"

@interface CCLoginTransaction : NSObject <CCTransaction>

@property (nonatomic, strong) CCMenuController *menuController;

@end
