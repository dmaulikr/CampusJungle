//
//  CCClassAddedTransaction.h
//  CampusJungle
//
//  Created by Yulia Petryshena on 6/6/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCTransactionWithObject.h"
#import "CCTransaction.h"

@interface CCClassAddedTransaction : NSObject <CCTransactionWithObject>

@property (nonatomic, strong) UINavigationController *navigation;
@property (nonatomic, strong) id <CCTransaction> inboxTransaction;

@end
