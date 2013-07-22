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
#import "CCEditClassTransaction.h"
#import "CCProfessorUploadsTransaction.h"
#import "CCTimetableTransaction.h"
#import "CCGroupTransaction.h"
#import "CCAddGroupTransaction.h"

@implementation CCClassTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.menuController);
    NSParameterAssert(object);
    NSParameterAssert(self.newsFeedTransaction);
    
    CCClassController *classController = [[CCClassController alloc] initWithClass:object];
    UINavigationController *centralNavigation = [[UINavigationController alloc] initWithRootViewController:classController];
    
    CCEditClassTransaction *editTransaction = [CCEditClassTransaction new];
    editTransaction.navigation = centralNavigation;
    editTransaction.classDataController = classController;
    classController.editClassTransaction = editTransaction;
    
    CCShowNotesForClassTransaction *classNotesTransaction = [CCShowNotesForClassTransaction new];
    classNotesTransaction.navigation = centralNavigation;
    classController.classMarketTransaction = classNotesTransaction;

    CCProfessorUploadsTransaction *professorUploadsTransaction = [CCProfessorUploadsTransaction new];
    professorUploadsTransaction.navigation = centralNavigation;
    classController.professorUploadsTransaction = professorUploadsTransaction;
    
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
    
    CCTimetableTransaction *timetableTransaction = [CCTimetableTransaction new];
    timetableTransaction.navigation = centralNavigation;
    
    CCGroupTransaction *groupDetailsTransaction = [CCGroupTransaction new];
    groupDetailsTransaction.navigation = centralNavigation;
    
    CCAddGroupTransaction *addGroupTransaction = [CCAddGroupTransaction new];
    addGroupTransaction.navigation = centralNavigation;
    
    classController.otherUserProfileTransaction = otherUserProfileTransaction;
    classController.newsFeedTransaction = self.newsFeedTransaction;
    classController.locationTransaction = showLocationsTransaction;
    classController.addLocationTransaction = addLocationTransaction;
    classController.addForumTransaction = addForumTransaction;
    classController.forumDetailsTransaction = forumDetailsTransaction;
    classController.timetableTransaction = timetableTransaction;
    classController.groupDetailsTransaction = groupDetailsTransaction;
    classController.addGroupTransaction = addGroupTransaction;
    
    [self.menuController setCenterPanel:centralNavigation];
}

@end
