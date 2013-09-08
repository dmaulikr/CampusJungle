//
//  CCAnnouncementTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 22.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAnnouncementTransaction.h"
#import "CCAnnouncementsController.h"
#import "CCAddAnnouncementTransaction.h"
#import "CCAnnouncementDetailsTransaction.h"

@implementation CCAnnouncementTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    CCAnnouncementsController *announcementsController = [CCAnnouncementsController new];
    announcementsController.currentClass = object;
    
    CCAnnouncementDetailsTransaction *announcementDetailsTransaction = [CCAnnouncementDetailsTransaction new];
    announcementDetailsTransaction.navigation = self.navigation;
    announcementsController.announcementDetailsTransaction = announcementDetailsTransaction;
    
    CCAddAnnouncementTransaction *addAnnnouncementTransaction = [CCAddAnnouncementTransaction new];
    addAnnnouncementTransaction.navigation = self.navigation;
    announcementsController.addAnnouncementTransaction = addAnnnouncementTransaction;
    
    [self.navigation pushViewController:announcementsController animated:YES];
}

@end
