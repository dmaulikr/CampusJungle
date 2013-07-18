//
//  CCClassAddedTransaction.m
//  CampusJungle
//
//  Created by Yulia Petryshena on 6/6/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCClassAddedTransaction.h"
#import "CCClassController.h"
#import "CCShowNotesForClassTransaction.h"
#import "CCOtherUserProfileTransaction.h"
#import "CCShowLocationsTransaction.h"
#import "CCAddLocationTransaction.h"
#import "CCAddForumTransaction.h"
#import "CCForumDetailsTransaction.h"
#import "CCEditClassTransaction.h"
#import "CCProfessorUploadsTransaction.h"

@implementation CCClassAddedTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    NSParameterAssert(self.inboxTransaction);
    
    CCClassController *classController = [[CCClassController alloc] initWithClass:object];
    [self.navigation pushViewController:classController animated:YES];
    
    CCEditClassTransaction *editTransaction = [CCEditClassTransaction new];
    editTransaction.navigation = self.navigation;
    classController.editClassTransaction = editTransaction;
    
    CCShowNotesForClassTransaction *classNotesTransaction = [CCShowNotesForClassTransaction new];
    classController.classMarketTransaction =classNotesTransaction;
    classNotesTransaction.navigation = self.navigation;
    
    CCProfessorUploadsTransaction *professorUploadsTransaction = [CCProfessorUploadsTransaction new];
    professorUploadsTransaction.navigation = self.navigation;
    classController.professorUploadsTransaction = professorUploadsTransaction;
    
    CCShowLocationsTransaction *locationsTransactions = [CCShowLocationsTransaction new];
    locationsTransactions.navigation = self.navigation;
    classController.locationTransaction = locationsTransactions;
    
    CCAddLocationTransaction *addLocationTransaction = [CCAddLocationTransaction new];
    addLocationTransaction.navigation = self.navigation;
    
    CCOtherUserProfileTransaction *otherUserProfileTransaction = [CCOtherUserProfileTransaction new];
    otherUserProfileTransaction.navigation = self.navigation;
    
    CCAddForumTransaction *addForumTransaction = [CCAddForumTransaction new];
    addForumTransaction.navigation = self.navigation;
    
    CCForumDetailsTransaction *forumDetailsTransaction = [CCForumDetailsTransaction new];
    forumDetailsTransaction.navigation = self.navigation;
    
    classController.otherUserProfileTransaction = otherUserProfileTransaction;
    classController.newsFeedTransaction = self.inboxTransaction;
    classController.locationTransaction = locationsTransactions;
    classController.addLocationTransaction = addLocationTransaction;
    classController.addForumTransaction = addForumTransaction;
    classController.forumDetailsTransaction = forumDetailsTransaction;
    
    [SVProgressHUD showSuccessWithStatus:CCSuccessMessages.joinClass duration:CCProgressHudsConstants.loaderDuration];
    UIViewController *viewController = [[self.navigation viewControllers] lastObject];
    [self.navigation setViewControllers:@[viewController]];
}

@end
