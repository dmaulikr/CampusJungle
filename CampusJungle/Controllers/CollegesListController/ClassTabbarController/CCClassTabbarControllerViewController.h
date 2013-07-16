//
//  CCClassTabbarControllerViewController.h
//  CampusJungle
//
//  Created by Vlad Korzun on 08.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCBaseViewController.h"
#import "CCClassTabbarControllerDelegateProtocol.h"

@interface CCClassTabbarControllerViewController : UIViewController

@property (nonatomic, weak)id<CCClassTabbarControllerDelegateProtocol> delegate;

- (NSInteger)selectedButtonIdentifier;

@end
