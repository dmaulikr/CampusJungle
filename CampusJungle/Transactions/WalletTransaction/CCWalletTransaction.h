//
//  CCWalletTransaction.h
//  CampusJungle
//
//  Created by Vlad Korzun on 30.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTransaction.h"

@interface CCWalletTransaction : NSObject<CCTransaction>

@property (nonatomic, weak) UINavigationController *navigation;

@end
