//
//  CCClassTransaction.h
//  CampusJungle
//
//  Created by Yulia Petryshena on 5/29/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "JASidePanelController.h"
#import "CCTransaction.h"

@interface CCClassTransaction : NSObject<CCTransaction>

@property (nonatomic, strong) JASidePanelController *menuController;

@end
