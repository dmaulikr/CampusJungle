//
//  CCBackToNotesListTransaction.h
//  CampusJungle
//
//  Created by Vlad Korzun on 19.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTransaction.h"

@interface CCBackToNotesListTransaction : NSObject<CCTransaction>

@property (nonatomic, weak) UINavigationController *navigation;

@end
