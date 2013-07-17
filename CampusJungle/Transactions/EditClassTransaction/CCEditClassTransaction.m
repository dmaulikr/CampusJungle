//
//  CCEditClassTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 17.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCEditClassTransaction.h"
#import "CCUpdateClassController.h"
#import "CCBackToClassTransactionAfterUpdate.h"

@implementation CCEditClassTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    CCUpdateClassController *updateClassController = [CCUpdateClassController new];
    
    CCBackToClassTransactionAfterUpdate *backTransaction = [CCBackToClassTransactionAfterUpdate new];
    backTransaction.navigation = self.navigation;
    backTransaction.classControler = self.classController;
    
    updateClassController.backToClassScreenTransaction = backTransaction;
    updateClassController.currentClass = object;
    [self.navigation pushViewController:updateClassController animated:YES];

}

@end
