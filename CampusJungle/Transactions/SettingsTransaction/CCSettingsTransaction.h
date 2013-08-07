//
//  CCSettingsTransaction.h
//  CampusJungle
//
//  Created by Vlad Korzun on 01.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTransaction.h"

@interface CCSettingsTransaction : NSObject<CCTransaction>

@property (nonatomic, weak) UINavigationController *navigation;

@end
