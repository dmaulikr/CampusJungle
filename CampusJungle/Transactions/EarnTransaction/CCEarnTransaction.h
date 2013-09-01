//
//  CCEarnTransaction.h
//  CampusJungle
//
//  Created by Vlad Korzun on 02.09.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTransaction.h"
#import "JASidePanelController.h"

@interface CCEarnTransaction : NSObject<CCTransaction>

@property (nonatomic, strong) JASidePanelController *menuController;

@end
