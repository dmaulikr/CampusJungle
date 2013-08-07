//
//  CCAddClassTransaction.h
//  CampusJungle
//
//  Created by Yulia Petryshena on 6/3/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCTransactionWithObject.h"
#import "CCTransaction.h"

@interface CCAddClassTransaction : NSObject <CCTransactionWithObject>

@property (nonatomic, weak) UINavigationController *navigation;
@property (nonatomic, strong) id <CCTransaction> inboxTransaction;

@end
