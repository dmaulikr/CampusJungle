//
//  CCAnswersTransaction.m
//  CampusJungle
//
//  Created by Yury Grinenko on 16.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAnswersTransaction.h"
#import "CCAnswersViewController.h"

@implementation CCAnswersTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    NSParameterAssert(object);
    
    CCAnswersViewController *answersController = [CCAnswersViewController new];
    [answersController setQuestion:object];
    [self.navigation pushViewController:answersController animated:YES];
}

@end
