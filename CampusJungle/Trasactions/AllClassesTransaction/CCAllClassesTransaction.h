//
//  CCAllClassesTransaction.h
//  CampusJungle
//
//  Created by Yulia Petryshena on 5/31/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCTransaction.h"
#import "JASidePanelController.h"

@interface CCAllClassesTransaction : NSObject <CCTransaction>

@property (nonatomic, strong) JASidePanelController *menuController;

@end
