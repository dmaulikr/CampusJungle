//
//  CCAddAnnouncementTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 22.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAddAnnouncementTransaction.h"
#import "CCAddAnnouncementController.h"
#import "CCBackTransaction.h"

@implementation CCAddAnnouncementTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    CCAddAnnouncementController *addAnoncementController = [CCAddAnnouncementController new];
    CCBackTransaction *backTransaction = [CCBackTransaction new];
    backTransaction.navigation = self.navigation;
    addAnoncementController.backToListTransaction = backTransaction;
    addAnoncementController.currentClass = object;
    [self.navigation pushViewController:addAnoncementController animated:YES];
}

@end
