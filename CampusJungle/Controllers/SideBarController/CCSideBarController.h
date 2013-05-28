//
//  CCSideBarController.h
//  CampusJungle
//
//  Created by Yulia Petryshena on 5/28/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//
#import "JASidePanelController.h"

typedef void (^ViewDidLoadBlock)();

@interface CCSideBarController : JASidePanelController

@property (nonatomic, copy) ViewDidLoadBlock blockOnViewDidAppear;


@end
