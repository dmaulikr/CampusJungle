//
//  CCEditGroupTransaction.m
//  CampusJungle
//
//  Created by Yury Grinenko on 23.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCEditGroupTransaction.h"
#import "CCBackTransaction.h"
#import "CCEditGroupViewController.h"

@implementation CCEditGroupTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    NSParameterAssert(object);
    
    id group = [object valueForKey:@"group"];
    id delegate = [object valueForKey:@"delegate"];
    
    CCBackTransaction *backTransaction = [CCBackTransaction new];
    backTransaction.navigation = self.navigation;
    
    CCEditGroupViewController *editGroupController = [CCEditGroupViewController new];
    [editGroupController setGroup:group];
    [editGroupController setDelegate:delegate];
    editGroupController.backTransaction = backTransaction;
    [self.navigation pushViewController:editGroupController animated:YES];
}

@end
