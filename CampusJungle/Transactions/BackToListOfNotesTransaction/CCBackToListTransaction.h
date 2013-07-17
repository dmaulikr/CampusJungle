//
//  CCBackToListOfNotesTransaction.h
//  CampusJungle
//
//  Created by Vlad Korzun on 09.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTransaction.h"
#import "CCBaseViewController.h"

@interface CCBackToListTransaction : NSObject <CCTransaction>

@property (nonatomic, strong) UINavigationController *navigation;
@property (nonatomic, strong) CCBaseViewController *listController;

@end
