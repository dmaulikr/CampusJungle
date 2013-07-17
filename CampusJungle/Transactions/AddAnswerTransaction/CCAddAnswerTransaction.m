//
//  CCAddAnswerTransaction.m
//  CampusJungle
//
//  Created by Yury Grinenko on 17.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAddAnswerTransaction.h"
#import "CCBackTransaction.h"
#import "CCAddAnswerViewController.h"

@implementation CCAddAnswerTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    NSParameterAssert(object);
    
    CCBackTransaction *backTransaction = [CCBackTransaction new];
    backTransaction.navigation = self.navigation;
    
    CCAddAnswerViewController *addAnswerController = [CCAddAnswerViewController new];
    [addAnswerController setQuestion:object];
    addAnswerController.backTransaction = backTransaction;
    
    [self.navigation pushViewController:addAnswerController animated:YES];
}

@end
