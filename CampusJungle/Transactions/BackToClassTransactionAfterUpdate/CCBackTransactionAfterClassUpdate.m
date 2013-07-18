//
//  CCBackTransactionAfterClassUpdate.m
//  CampusJungle
//
//  Created by Vlad Korzun on 17.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCBackTransactionAfterClassUpdate.h"

@implementation CCBackTransactionAfterClassUpdate

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    NSParameterAssert(self.previousController);
    
    [self.previousController updateWithClass:object];
    [self.navigation popViewControllerAnimated:YES];
    [SVProgressHUD showSuccessWithStatus:@"Succesfuly Updated" duration:CCProgressHudsConstants.loaderDuration];
}

@end
