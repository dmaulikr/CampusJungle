//
//  CCMyStuffTransaction.h
//  CampusJungle
//
//  Created by Vlad Korzun on 20.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTransaction.h"

@interface CCMyStuffTransaction : NSObject <CCTransaction>

@property (nonatomic, strong) UINavigationController *navigation;

@end
