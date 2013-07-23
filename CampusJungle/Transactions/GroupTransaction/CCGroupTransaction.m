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
#import "CCAddForumTransaction.h"
#import "CCForumDetailsTransaction.h"
#import "CCBackTransaction.h"
#import "CCGroupMessageTransaction.h"
#import "CCEditGroupTransaction.h"
#import "CCMessageDetailsTransaction.h"

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
    
    CCAddForumTransaction *addForumTransaction = [CCAddForumTransaction new];
    addForumTransaction.navigation = self.navigation;
    
    CCForumDetailsTransaction *forumDetailsTransaction = [CCForumDetailsTransaction new];
    forumDetailsTransaction.navigation = self.navigation;
    
    CCBackTransaction *backTransaction = [CCBackTransaction new];
    backTransaction.navigation = self.navigation;
    
    CCGroupMessageTransaction *groupMessageTransaction = [CCGroupMessageTransaction new];
    groupMessageTransaction.navigation = self.navigation;
    
    CCEditGroupTransaction *editGroupTransaction = [CCEditGroupTransaction new];
    editGroupTransaction.navigation = self.navigation;
    editGroupTransaction.classController = classController;
    
    CCMessageDetailsTransaction *messageDetailsTransaction = [CCMessageDetailsTransaction new];
    messageDetailsTransaction.navigation = self.navigation;
    
    CCGroupViewController *groupController = [CCGroupViewController new];
    groupController.locationTransaction = locationsTransaction;
    groupController.addLocationTransaction = addLocationTransaction;
    groupController.otherUserProfileTransaction = otherUserProfileTransaction;
    groupController.forumDetailsTransaction = forumDetailsTransaction;
    groupController.addForumTransaction = addForumTransaction;
    groupController.backTransaction = backTransaction;
    groupController.groupMessageTransaction = groupMessageTransaction;
    groupController.editGroupTransaction = editGroupTransaction;
    groupController.messageDetailsTransaction = messageDetailsTransaction;
    
    [groupController setGroup:group];
    [self.navigation pushViewController:groupController animated:YES];
}

@end
