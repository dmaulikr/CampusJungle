//
//  CCClassesOfcurrentCollegeTransaction.h
//  CampusJungle
//
//  Created by Yulia Petryshena on 6/5/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCTransactionWithObject.h"
#import "JASidePanelController.h"
#import "CCTransaction.h"

@interface CCClassesOfCollegeTransaction : NSObject <CCTransactionWithObject>

@property (nonatomic, strong) JASidePanelController *menuController;
@property (nonatomic, strong) id <CCTransaction> inboxTransaction;

@end
