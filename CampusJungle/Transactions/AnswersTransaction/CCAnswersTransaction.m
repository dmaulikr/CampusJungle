//
//  CCAnswersTransaction.m
//  CampusJungle
//
//  Created by Yury Grinenko on 16.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAnswersTransaction.h"
#import "CCAnswersViewController.h"
#import "CCAddAnswerTransaction.h"
#import "CCCommentsTransaction.h"
#import "CCViewPDFTransaction.h"

@implementation CCAnswersTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    NSParameterAssert(object);
    
    CCAddAnswerTransaction *addAnswerTransaction = [CCAddAnswerTransaction new];
    addAnswerTransaction.navigation = self.navigation;
    
    CCViewPDFTransaction *viewPDFTransaction = [CCViewPDFTransaction new];
    viewPDFTransaction.navigation = self.navigation;
    
    CCCommentsTransaction *commentsTransaction = [CCCommentsTransaction new];
    commentsTransaction.navigation = self.navigation;
    
    CCAnswersViewController *answersController = [CCAnswersViewController new];
    [answersController setQuestion:object];
    answersController.addAnswerTransaction = addAnswerTransaction;
    answersController.showCommentsTransaction = commentsTransaction;
    answersController.viewAttacmentTransaction = viewPDFTransaction;
    
    [self.navigation pushViewController:answersController animated:YES];
}

@end
