//
//  CCGroupTableController.h
//  CampusJungle
//
//  Created by Vlad Korzun on 08.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCTableBaseViewController.h"
#import "CCGroupTableDelegate.h"

@class CCGroup;

@interface CCGroupTableController : CCTableBaseViewController

@property (nonatomic, weak) UIView *tableHeaderView;
@property (nonatomic, weak) id<CCGroupTableDelegate> delegate;

- (void)setGroup:(CCGroup *)group;

@end
