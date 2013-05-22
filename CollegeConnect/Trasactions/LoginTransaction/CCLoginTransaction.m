//
//  CCLoginTransaction.m
//  CollegeConnect
//
//  Created by Vlad Korzun on 22.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCLoginTransaction.h"

@implementation CCLoginTransaction

- (void)perform
{
    [self.menuController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
