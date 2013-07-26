//
//  CCVoteScreenTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 25.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCVoteScreenTransaction.h"
#import "CCVoteScreenController.h"

@implementation CCVoteScreenTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    CCVoteScreenController *voteController = [CCVoteScreenController new];
    voteController.voteResultTransaction = self.voteResultTransaction;
    voteController.currentClass = object;
    [self.navigation pushViewController:voteController animated:YES];
}

@end
