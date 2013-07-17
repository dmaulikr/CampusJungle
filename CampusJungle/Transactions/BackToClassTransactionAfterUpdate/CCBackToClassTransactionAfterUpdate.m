//
//  CCBackToClassTransactionAfterUpdate.m
//  CampusJungle
//
//  Created by Vlad Korzun on 17.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCBackToClassTransactionAfterUpdate.h"

@implementation CCBackToClassTransactionAfterUpdate

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    
    [self.classControler updateWithClass:object];
    [self.navigation popToViewController:self.classControler animated:YES];
    [SVProgressHUD showSuccessWithStatus:@"Succesfuly Updated" duration:CCProgressHudsConstants.loaderDuration];
}

@end
