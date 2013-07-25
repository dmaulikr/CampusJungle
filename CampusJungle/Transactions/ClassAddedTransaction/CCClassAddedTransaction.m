//
//  CCClassAddedTransaction.m
//  CampusJungle
//
//  Created by Yulia Petryshena on 6/6/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCClassAddedTransaction.h"

@implementation CCClassAddedTransaction

- (void)performWithObject:(id)object
{
    [super performWithObject:object];
    [SVProgressHUD showSuccessWithStatus:CCSuccessMessages.joinClass duration:CCProgressHudsConstants.loaderDuration];
}

@end
