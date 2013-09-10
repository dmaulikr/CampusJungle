//
//  CCAnnouncementDetailsTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 07.09.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAnnouncementDetailsTransaction.h"
#import "CCAnoncementsDetailsController.h"

@implementation CCAnnouncementDetailsTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    CCAnoncementsDetailsController *announcementCountroller = [CCAnoncementsDetailsController new];
    announcementCountroller.announcement = object;
    [self.navigation pushViewController:announcementCountroller animated:YES];
}

@end
