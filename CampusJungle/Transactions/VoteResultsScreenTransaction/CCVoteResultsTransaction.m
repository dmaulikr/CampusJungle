//
//  CCVoteResultsTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 25.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCVoteResultsTransaction.h"
#import "CCVoteResultScreenController.h"

@implementation CCVoteResultsTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    CCVoteResultScreenController *voteController = [CCVoteResultScreenController new];
    voteController.currentClass = object;
    [self.navigation pushViewController:voteController animated:YES];
}

@end
