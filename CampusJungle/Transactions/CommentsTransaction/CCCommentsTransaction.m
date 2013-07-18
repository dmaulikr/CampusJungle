//
//  CCCommentsTransaction.m
//  CampusJungle
//
//  Created by Yury Grinenko on 17.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCCommentsTransaction.h"
#import "CCCommentsViewController.h"
#import "CCAddCommentTransaction.h"

@implementation CCCommentsTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    NSParameterAssert(object);
    
    CCAddCommentTransaction *addCommentTransaction = [CCAddCommentTransaction new];
    addCommentTransaction.navigation = self.navigation;
    
    CCCommentsViewController *commentsController = [CCCommentsViewController new];
    [commentsController setAnswer:object];
    commentsController.addCommentTransaction = addCommentTransaction;
    
    [self.navigation pushViewController:commentsController animated:YES];
}

@end
