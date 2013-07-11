//
//  CCBackTransaction.h
//  CampusJungle
//
//  Created by Yury Grinenko on 11.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTransaction.h"

@interface CCBackTransaction : NSObject <CCTransaction>

@property (nonatomic, strong) UINavigationController *navigation;

@end
