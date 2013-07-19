//
//  CCInitialUserInfoTransaction.h
//  CollegeConnect
//
//  Created by Vlad Korzun on 23.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCTransaction.h"
#import "JASidePanelController.h"

@interface CCInitialUserProfileTransaction : NSObject <CCTransaction>

@property (nonatomic, strong) id<CCTransaction> loginTransaction;
@property (nonatomic, strong) JASidePanelController *baseViewController;
@property (nonatomic, strong) UINavigationController *navigation;

@end
