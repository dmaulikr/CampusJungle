//
//  CCBackToNoteTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 11.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCBackToNoteTransaction.h"

@implementation CCBackToNoteTransaction

- (void)perform
{
    NSParameterAssert(self.navigation);
    
    [self.navigation popViewControllerAnimated:YES];
    [SVProgressHUD showSuccessWithStatus:@"Review posted" duration:CCProgressHudsConstants.loaderDuration];
}

@end
