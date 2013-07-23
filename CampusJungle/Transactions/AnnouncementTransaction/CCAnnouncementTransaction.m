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

@implementation CCAnnouncementTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    CCAnnouncementsController *announcementsController = [CCAnnouncementsController new];
    announcementsController.currentClass = object;
    
    CCAddAnnouncementTransaction *addAnnnouncementTransaction = [CCAddAnnouncementTransaction new];
    addAnnnouncementTransaction.navigation = self.navigation;
    announcementsController.addAnnouncementTransaction = addAnnnouncementTransaction;
    
    [self.navigation pushViewController:announcementsController animated:YES];
}

@end
