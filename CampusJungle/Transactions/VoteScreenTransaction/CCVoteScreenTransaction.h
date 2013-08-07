//
//  CCVoteScreenTransaction.h
//  CampusJungle
//
//  Created by Vlad Korzun on 25.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTransactionWithObject.h"
#import "CCTransaction.h"

@interface CCVoteScreenTransaction : NSObject<CCTransactionWithObject>

@property (nonatomic, weak) UINavigationController *navigation;
@property (nonatomic, strong) id <CCTransaction> backToClassTransaction;
@property (nonatomic, strong) id <CCTransactionWithObject> voteResultTransaction;

@end
