//
//  CCUserProfileTransaction.h
//  CollegeConnect
//
//  Created by Vlad Korzun on 24.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "JASidePanelController.h"
#import "CCTransaction.h"

@interface CCUserProfileTransaction : NSObject<CCTransaction>

@property (nonatomic, strong) JASidePanelController *menuController;

@end
