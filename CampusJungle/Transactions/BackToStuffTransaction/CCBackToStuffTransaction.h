//
//  CCBackToStuffTransaction.h
//  CampusJungle
//
//  Created by Vlad Korzun on 09.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTransaction.h"

@interface CCBackToStuffTransaction : NSObject<CCTransaction>

@property (nonatomic, strong) UINavigationController *navigation;

@end
