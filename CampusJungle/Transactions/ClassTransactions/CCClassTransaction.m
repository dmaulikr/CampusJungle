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
#import "CCEditClassTransaction.h"
#import "CCProfessorUploadsTransaction.h"
#import "CCTimetableTransaction.h"
#import "CCGroupTransaction.h"
#import "CCAddGroupTransaction.h"
#import "CCAnnouncementTransaction.h"
#import "CCVoteResultsTransaction.h"
#import "CCVoteScreenTransaction.h"
#import "CCBackToControllerTransaction.h"
#import "CCAppInviteTransaction.h"
#import "CCCouponsTransaction.h"
#import "CCAddQuestionTransaction.h"
#import "CCAnswersTransaction.h"
#import "CCViewPDFTransaction.h"

@implementation CCClassTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.menuController);
    NSParameterAssert(object);
    NSParameterAssert(self.newsFeedTransaction);
    
    CCClassController *classController = [[CCClassController alloc] initWithClass:object];
    UINavigationController *centralNavigation = [[UINavigationController alloc] initWithRootViewController:classController];
    
    CCBackToControllerTransaction *backToClassTransaction = [CCBackToControllerTransaction new];
    backToClassTransaction.navigation = centralNavigation;
    backToClassTransaction.targetController = classController;
    
    CCVoteResultsTransaction *voteResultsTransaction = [CCVoteResultsTransaction new];
    voteResultsTransaction.navigation = centralNavigation;
    classController.voteResultTransaction = voteResultsTransaction;
    
    CCVoteScreenTransaction *voteScreenTransaction = [CCVoteScreenTransaction new];
    voteScreenTransaction.navigation = centralNavigation;
    classController.voteScreenTransaction = voteScreenTransaction;
    voteScreenTransaction.voteResultTransaction = voteResultsTransaction;
    
    voteScreenTransaction.backToClassTransaction = backToClassTransaction;
    voteResultsTransaction.backToClassTransaction = backToClassTransaction;
    
    CCAnnouncementTransaction *announcement = [CCAnnouncementTransaction new];
    announcement.navigation = centralNavigation; 
    classController.announcementTransaction = announcement;
    
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
    
    CCAddQuestionTransaction *addQuestionTransaction = [CCAddQuestionTransaction new];
    addQuestionTransaction.navigation = centralNavigation;
    
    CCAnswersTransaction *questionDetailsTransaction = [CCAnswersTransaction new];
    questionDetailsTransaction.navigation = centralNavigation;
    
    CCTimetableTransaction *timetableTransaction = [CCTimetableTransaction new];
    timetableTransaction.navigation = centralNavigation;
    
    CCGroupTransaction *groupDetailsTransaction = [CCGroupTransaction new];
    groupDetailsTransaction.navigation = centralNavigation;
    
    CCAddGroupTransaction *addGroupTransaction = [CCAddGroupTransaction new];
    addGroupTransaction.navigation = centralNavigation;
    
    CCAppInviteTransaction *appInviteTransaction = [CCAppInviteTransaction new];
    appInviteTransaction.navigation = centralNavigation;
    
    CCCouponsTransaction *couponsTransaction = [CCCouponsTransaction new];
    couponsTransaction.navigation = centralNavigation;
    
    CCViewPDFTransaction *viewPdfTransaction = [CCViewPDFTransaction new];
    viewPdfTransaction.navigation = centralNavigation;
    
    classController.otherUserProfileTransaction = otherUserProfileTransaction;
    classController.newsFeedTransaction = self.newsFeedTransaction;
    classController.locationTransaction = showLocationsTransaction;
    classController.addLocationTransaction = addLocationTransaction;
    classController.addQuestionTransaction = addQuestionTransaction;
    classController.questionDetailsTransaction = questionDetailsTransaction;
    classController.timetableTransaction = timetableTransaction;
    classController.groupDetailsTransaction = groupDetailsTransaction;
    classController.addGroupTransaction = addGroupTransaction;
    classController.sendInviteTransaction = appInviteTransaction;
    classController.couponsTransaction = couponsTransaction;
    classController.viewPdfAttachmentTransaction = viewPdfTransaction;
    
    [self.menuController setCenterPanel:centralNavigation];
}

@end
