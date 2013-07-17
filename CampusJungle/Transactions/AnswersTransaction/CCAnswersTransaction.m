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

@implementation CCAnswersTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    NSParameterAssert(object);
    
    CCAddAnswerTransaction *addAnswerTransaction = [CCAddAnswerTransaction new];
    addAnswerTransaction.navigation = self.navigation;
    
    CCAnswersViewController *answersController = [CCAnswersViewController new];
    [answersController setQuestion:object];
    answersController.addAnswerTransaction = addAnswerTransaction;
    [self.navigation pushViewController:answersController animated:YES];
}

@end
