//
//  CCForumDetailsTransaction.m
//  CampusJungle
//
//  Created by Yury Grinenko on 15.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCForumDetailsTransaction.h"
#import "CCQuestionsViewController.h"
#import "CCAddQuestionTransaction.h"

@implementation CCForumDetailsTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    NSParameterAssert(object);
    
    CCAddQuestionTransaction *addQuestionTransaction = [CCAddQuestionTransaction new];
    addQuestionTransaction.navigation = self.navigation;
    
    CCQuestionsViewController *questionsController = [CCQuestionsViewController new];
    [questionsController setForum:object];
    questionsController.addQuestionTransaction = addQuestionTransaction;
    
    [self.navigation pushViewController:questionsController animated:YES];
}

@end
