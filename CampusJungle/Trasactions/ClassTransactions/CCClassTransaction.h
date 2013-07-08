//
//  CCClassTransaction.h
//  CampusJungle
//
//  Created by Yulia Petryshena on 5/29/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "JASidePanelController.h"
#import "CCTransactionWithObject.h"
#import "CCTransaction.h"

@interface CCClassTransaction : NSObject<CCTransactionWithObject>

@property (nonatomic, strong) JASidePanelController *menuController;
@property (nonatomic, strong) id<CCTransaction> newsFeedTransaction;

@end
