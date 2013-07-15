//
//  CCCloseBrowserTransaction.h
//  CampusJungle
//
//  Created by Vlad Korzun on 22.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTransaction.h"

@interface CCCloseBrowserTransaction : NSObject<CCTransaction>

@property (nonatomic, strong) UIViewController *containerController;

@end
