//
//  CCAddQuestionTransaction.m
//  CampusJungle
//
//  Created by Yury Grinenko on 15.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAddQuestionTransaction.h"
#import "CCAddQuestionViewController.h"

@implementation CCAddQuestionTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    NSParameterAssert(object);
    
    CCAddQuestionViewController *addQuestionController = [CCAddQuestionViewController new];
    [addQuestionController setForum:object];
    [self.navigation pushViewController:addQuestionController animated:YES];
}

@end
