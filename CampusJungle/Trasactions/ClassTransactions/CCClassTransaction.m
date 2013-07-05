//
//  CCClassTransaction.m
//  CampusJungle
//
//  Created by Yulia Petryshena on 5/29/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCClassTransaction.h"
#import "CCClassController.h"
#import "CCShowNotesForClassTransaction.h"
#import "CCOtherUserProfileTransaction.h"

@implementation CCClassTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.menuController);
    NSParameterAssert(object);
    
    CCClassController *classController = [[CCClassController alloc] initWithClass:object];
    
    CCShowNotesForClassTransaction *classNotesTransaction = [CCShowNotesForClassTransaction new];
    classController.classMarketTransaction =classNotesTransaction;

    CCOtherUserProfileTransaction *otherUserProfileTransaction = [CCOtherUserProfileTransaction new];
    
    classController.otherUserProfileTransaction = otherUserProfileTransaction;
    
    UINavigationController *centralNavigation = [[UINavigationController alloc] initWithRootViewController:classController];
    [self.menuController setCenterPanel:centralNavigation];
    classNotesTransaction.navigation = centralNavigation;
    otherUserProfileTransaction.navigation = centralNavigation;
}

@end
