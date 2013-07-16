//
//  CCMyNotesTransaction.h
//  CampusJungle
//
//  Created by Vlad Korzun on 07.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTransaction.h"

@interface CCMyNotesTransaction : NSObject <CCTransaction>

@property (nonatomic, strong) UINavigationController *navigation;

@end
