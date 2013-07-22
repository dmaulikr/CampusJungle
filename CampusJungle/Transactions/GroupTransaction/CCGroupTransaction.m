//
//  CCGroupTransaction.m
//  CampusJungle
//
//  Created by Yury Grinenko on 22.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCGroupTransaction.h"
#import "CCGroupViewController.h"

@implementation CCGroupTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(object);
    NSParameterAssert(self.navigation);
    
    CCGroupViewController *groupController = [CCGroupViewController new];
    [groupController setGroup:object];
    [self.navigation pushViewController:groupController animated:YES];
}

@end
