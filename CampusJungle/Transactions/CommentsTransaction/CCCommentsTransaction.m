//
//  CCCommentsTransaction.m
//  CampusJungle
//
//  Created by Yury Grinenko on 17.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCCommentsTransaction.h"
#import "CCCommentsViewController.h"

@implementation CCCommentsTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    NSParameterAssert(object);
    
    CCCommentsViewController *commentsController = [CCCommentsViewController new];
    [commentsController setAnswer:object];
    
    [self.navigation pushViewController:commentsController animated:YES];
}

@end
