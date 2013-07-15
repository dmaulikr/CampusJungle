//
//  CCBackTransaction.m
//  CampusJungle
//
//  Created by Yury Grinenko on 11.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCBackTransaction.h"

@implementation CCBackTransaction

- (void)perform
{
    [self.navigation popViewControllerAnimated:YES];
}

@end
