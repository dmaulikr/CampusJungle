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
#import "CCShowLocationsTransaction.h"
#import "CCAddLocationTransaction.h"
#import "CCAddForumTransaction.h"
#import "CCForumDetailsTransaction.h"

@implementation CCClassTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.menuController);
    NSParameterAssert(object);
    NSParameterAssert(self.newsFeedTransaction);
    
    CCClassController *classController = [[CCClassController alloc] initWithClass:object];
    UINavigationController *centralNavigation = [[UINavigationController alloc] initWithRootViewController:classController];
    
    CCShowNotesForClassTransaction *classNotesTransaction = [CCShowNotesForClassTransaction new];
    classNotesTransaction.navigation = centralNavigation;
    classController.classMarketTransaction = classNotesTransaction;

    CCOtherUserProfileTransaction *otherUserProfileTransaction = [CCOtherUserProfileTransaction new];
    otherUserProfileTransaction.navigation = centralNavigation;
    
    CCShowLocationsTransaction *showLocationsTransaction = [CCShowLocationsTransaction new];
    showLocationsTransaction.navigation = centralNavigation;
    
    CCAddLocationTransaction *addLocationTransaction = [CCAddLocationTransaction new];
    addLocationTransaction.navigation = centralNavigation;
    
    CCAddForumTransaction *addForumTransaction = [CCAddForumTransaction new];
    addForumTransaction.navigation = centralNavigation;
    
    CCForumDetailsTransaction *forumDetailsTransaction = [CCForumDetailsTransaction new];
    forumDetailsTransaction.navigation = centralNavigation;
    
    classController.otherUserProfileTransaction = otherUserProfileTransaction;
    classController.newsFeedTransaction = self.newsFeedTransaction;
    classController.locationTransaction = showLocationsTransaction;
    classController.addLocationTransaction = addLocationTransaction;
    classController.addForumTransaction = addForumTransaction;
    classController.forumDetailsTransaction = forumDetailsTransaction;
    
    [self.menuController setCenterPanel:centralNavigation];
}

@end
