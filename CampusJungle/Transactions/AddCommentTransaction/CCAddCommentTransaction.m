//
//  CCAddCommentTransaction.m
//  CampusJungle
//
//  Created by Yury Grinenko on 18.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAddCommentTransaction.h"
#import "CCAddCommentViewController.h"
#import "CCBackTransaction.h"

@implementation CCAddCommentTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    NSParameterAssert(object);
    
    CCBackTransaction *backTransaction = [CCBackTransaction new];
    backTransaction.navigation = self.navigation;
    
    CCAddCommentViewController *addCommentController = [CCAddCommentViewController new];
    [addCommentController setAnswer:object];
    addCommentController.backTransaction = backTransaction;
    
    [self.navigation pushViewController:addCommentController animated:YES];
}

@end
