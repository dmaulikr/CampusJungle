//
//  CCPushToClassControllerTransaction.h
//  CampusJungle
//
//  Created by Vlad Korzun on 25.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTransaction.h"
#import "CCTransactionWithObject.h"

@interface CCPushToClassControllerTransaction : NSObject<CCTransactionWithObject>

@property (nonatomic, strong) UINavigationController *navigation;
@property (nonatomic, strong) id <CCTransaction> inboxTransaction;

@end
