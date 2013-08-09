//
//  CCStuffMarketTransaction.h
//  CampusJungle
//
//  Created by Vlad Korzun on 09.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTransaction.h"
#import "JASidePanelController.h"
#import "CCUserSessionProtocol.h"

@interface CCStuffMarketTransaction : NSObject<CCTransaction>

@property (nonatomic, strong) JASidePanelController *menuController;
@property (nonatomic, strong) id <CCUserSessionProtocol> ioc_userSessionProtocol;

@end
