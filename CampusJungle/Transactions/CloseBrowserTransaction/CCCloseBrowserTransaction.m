//
//  CCCloseBrowserTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 22.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCCloseBrowserTransaction.h"

@implementation CCCloseBrowserTransaction

- (void)perform
{
    NSParameterAssert(self.containerController);
    [self.containerController dismissViewControllerAnimated:YES completion:nil];
}

@end
