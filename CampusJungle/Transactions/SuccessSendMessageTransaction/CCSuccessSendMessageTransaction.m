//
//  CCSuccessSendMessageTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 10.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCSuccessSendMessageTransaction.h"

@implementation CCSuccessSendMessageTransaction

- (void)perform
{
    NSParameterAssert(self.navigation);
    
    [self.navigation popViewControllerAnimated:YES];
    [SVProgressHUD showSuccessWithStatus:@"Message successfuly sent" duration:CCProgressHudsConstants.loaderDuration];
}

@end
