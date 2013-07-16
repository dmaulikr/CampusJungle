//
//  CCWelcomeScreenConfigurator.h
//  CollegeConnect
//
//  Created by Vlad Korzun on 23.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCSideMenuController.h"
#import "JASidePanelController.h"

@interface CCWelcomeScreenConfigurator : NSObject

+ (UINavigationController *)configureWithBaseController:(JASidePanelController *)sidePanel;

@end
