//
//  CCClassTableController.h
//  CampusJungle
//
//  Created by Vlad Korzun on 08.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCTableBaseViewController.h"
#import "CCClassTableDelegate.h"

@interface CCClassTableController : CCTableBaseViewController

@property (nonatomic, strong) NSString *classID;
@property (nonatomic, weak) UIView *tableHeaderView;

@property (nonatomic, weak) id<CCClassTableDelegate> delegate;

@end
