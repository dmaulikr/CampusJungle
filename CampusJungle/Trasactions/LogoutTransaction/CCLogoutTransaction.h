//
//  CCLogoutTransaction.h
//  CollegeConnect
//
//  Created by Vlad Korzun on 23.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTransaction.h"
#import "CCMenuController.h"
#import "JASidePanelController.h"


@interface CCLogoutTransaction : NSObject<CCTransaction>

@property (nonatomic, strong) JASidePanelController *rootMenuController;

@end
