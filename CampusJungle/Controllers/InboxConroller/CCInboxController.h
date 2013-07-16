//
//  CCInboxControllerViewController.h
//  CampusJungle
//
//  Created by Vlad Korzun on 25.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCTableBasedController.h"
#import "CCTransactionWithObject.h"

@interface CCInboxController : CCTableBasedController

@property (nonatomic, strong) id <CCTransactionWithObject> offerDetailsTransaction;
@property (nonatomic, strong) id <CCTransactionWithObject> messageDetailsTransaction;

@end
