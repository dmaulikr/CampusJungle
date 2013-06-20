//
//  CCMyStuffController.h
//  CampusJungle
//
//  Created by Vlad Korzun on 20.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCTableBasedController.h"
#import "CCTransaction.h"

@interface CCMyStuffController : CCTableBasedController

@property (nonatomic, strong) id <CCTransaction> createStuffTransaction;

@end
