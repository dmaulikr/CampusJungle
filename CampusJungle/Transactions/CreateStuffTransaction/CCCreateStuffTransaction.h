//
//  CCCreateStuffTransaction.h
//  CampusJungle
//
//  Created by Vlad Korzun on 20.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTransaction.h"

@interface CCCreateStuffTransaction : NSObject<CCTransaction>

@property (nonatomic, weak) UINavigationController *navigation;
@property (nonatomic, strong) id <CCTransaction> backToListTransaction;

@end
