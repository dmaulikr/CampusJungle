//
//  CCInviterTransaction.h
//  CampusJungle
//
//  Created by Vlad Korzun on 31.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTransaction.h"

@interface CCInviterTransaction : NSObject <CCTransaction>

@property (nonatomic, weak) UINavigationController *navigation;
@property (nonatomic, strong) id <CCTransaction> tutorialTransaction;

@end
