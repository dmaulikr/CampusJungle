//
//  CCBackToStuffTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 09.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCBackToStuffTransaction.h"

@implementation CCBackToStuffTransaction

- (void)perform
{
    NSParameterAssert(self.navigation);
    
    [self.navigation popViewControllerAnimated:YES];
    [SVProgressHUD showSuccessWithStatus:@"Offer successfuly sent" duration:CCProgressHudsConstants.loaderDuration];
}

@end
