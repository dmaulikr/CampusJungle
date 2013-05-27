//
//  CCSideMenuTransaction.h
//  CampusJungle
//
//  Created by Yulia Petryshena on 5/27/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCTransaction.h"
#import "JASidePanelController.h"

@interface CCSideMenuTransaction : NSObject <CCTransaction>

@property (nonatomic, weak) JASidePanelController *centralPanel;

@end
