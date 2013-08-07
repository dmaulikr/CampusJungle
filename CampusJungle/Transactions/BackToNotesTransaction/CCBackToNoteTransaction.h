//
//  CCBackToNoteTransaction.h
//  CampusJungle
//
//  Created by Vlad Korzun on 11.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTransaction.h"

@interface CCBackToNoteTransaction : NSObject<CCTransaction>

@property (nonatomic, weak) UINavigationController *navigation;

@end
