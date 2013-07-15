//
//  CCInboxTransAction.h
//  CampusJungle
//
//  Created by Vlad Korzun on 01.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTransaction.h"
#import "JASidePanelController.h"

@interface CCInboxTransaction : NSObject<CCTransaction>

@property (nonatomic, strong) JASidePanelController *menuController;

@end
