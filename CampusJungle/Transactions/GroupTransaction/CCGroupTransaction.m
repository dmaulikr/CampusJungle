//
//  CCGroupTransaction.m
//  CampusJungle
//
//  Created by Yury Grinenko on 22.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCGroupTransaction.h"
#import "CCGroupViewController.h"

#import "CCShowLocationsTransaction.h"
#import "CCAddLocationTransaction.h"
#import "CCOtherUserProfileTransaction.h"
#import "CCAddQuestionTransaction.h"
#import "CCAnswersTransaction.h"
#import "CCBackTransaction.h"
#import "CCGroupMessageTransaction.h"
#import "CCEditGroupTransaction.h"
#import "CCMessageDetailsTransaction.h"
#import "CCSendGroupInviteTransaction.h"
#import "CCViewPDFTransaction.h"

@implementation CCGroupTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(object);
    NSParameterAssert(self.navigation);
    
    id group = [object valueForKey:@"group"];
    id classController = [object valueForKey:@"controller"];
    
    CCShowLocationsTransaction *locationsTransaction = [CCShowLocationsTransaction new];
    locationsTransaction.navigation = self.navigation;
    
    CCAddLocationTransaction *addLocationTransaction = [CCAddLocationTransaction new];
    addLocationTransaction.navigation = self.navigation;
    
    CCOtherUserProfileTransaction *otherUserProfileTransaction = [CCOtherUserProfileTransaction new];
    otherUserProfileTransaction.navigation = self.navigation;
    
    CCAddQuestionTransaction *addQuestionTransaction = [CCAddQuestionTransaction new];
    addQuestionTransaction.navigation = self.navigation;
    
    CCAnswersTransaction *questionDetailsTransaction = [CCAnswersTransaction new];
    questionDetailsTransaction.navigation = self.navigation;
    
    CCBackTransaction *backTransaction = [CCBackTransaction new];
    backTransaction.navigation = self.navigation;
    
    CCGroupMessageTransaction *groupMessageTransaction = [CCGroupMessageTransaction new];
    groupMessageTransaction.navigation = self.navigation;
    
    CCEditGroupTransaction *editGroupTransaction = [CCEditGroupTransaction new];
    editGroupTransaction.navigation = self.navigation;
    editGroupTransaction.classController = classController;
    
    CCMessageDetailsTransaction *messageDetailsTransaction = [CCMessageDetailsTransaction new];
    messageDetailsTransaction.navigation = self.navigation;
    
    CCSendGroupInviteTransaction *sendGroupInviteTransaction = [CCSendGroupInviteTransaction new];
    sendGroupInviteTransaction.navigation = self.navigation;
    
    CCViewPDFTransaction *viewPdfTransaction = [CCViewPDFTransaction new];
    viewPdfTransaction.navigation = self.navigation;
    
    CCGroupViewController *groupController = [CCGroupViewController new];
    groupController.locationTransaction = locationsTransaction;
    groupController.addLocationTransaction = addLocationTransaction;
    groupController.otherUserProfileTransaction = otherUserProfileTransaction;
    groupController.questionDetailsTransaction = questionDetailsTransaction;
    groupController.addQuestionTransaction = addQuestionTransaction;
    groupController.backTransaction = backTransaction;
    groupController.groupMessageTransaction = groupMessageTransaction;
    groupController.editGroupTransaction = editGroupTransaction;
    groupController.messageDetailsTransaction = messageDetailsTransaction;
    groupController.sendGroupInviteTransaction = sendGroupInviteTransaction;
    groupController.viewPdfAttachmentTransaction = viewPdfTransaction;
    
    [groupController setGroup:group];
    [self.navigation pushViewController:groupController animated:YES];
}

@end
