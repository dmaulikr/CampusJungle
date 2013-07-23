//
//  CCBackToControllerTransaction.h
//  CampusJungle
//
//  Created by Yury Grinenko on 23.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTransaction.h"

@interface CCBackToControllerTransaction : NSObject <CCTransaction>

@property (nonatomic, strong) UINavigationController *navigation;
@property (nonatomic, strong) UIViewController *targetController;

@end
