//
//  CCMarketTranasction.h
//  CampusJungle
//
//  Created by Vlad Korzun on 12.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JASidePanelController.h"
#import "CCTransaction.h"

@interface CCMarketTranasction : NSObject<CCTransaction>

@property (nonatomic, strong) JASidePanelController *menuController;

@end
