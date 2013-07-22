//
//  CCGroupTabbarViewController.h
//  CampusJungle
//
//  Created by Yury Grinenko on 22.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCGroupTabbarDelegate.h"

@interface CCGroupTabbarViewController : UIViewController

@property (nonatomic, weak) id<CCGroupTabbarDelegate> delegate;

- (NSInteger)selectedButtonIdentifier;

@end
