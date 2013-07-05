//
//  CCClassAddedTransaction.m
//  CampusJungle
//
//  Created by Yulia Petryshena on 6/6/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCClassAddedTransaction.h"
#import "CCClassController.h"

@implementation CCClassAddedTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    
    CCClassController *classController = [[CCClassController alloc] initWithClass:object];
    [self.navigation pushViewController:classController animated:YES];
    
    [SVProgressHUD showSuccessWithStatus:CCSuccessMessages.joinClass duration:CCProgressHudsConstants.loaderDuration];
    UIViewController *viewController = [[self.navigation viewControllers] lastObject];
    [self.navigation setViewControllers:@[viewController]];
}

@end
