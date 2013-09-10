//
//  CCEditClassTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 17.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCEditClassTransaction.h"
#import "CCUpdateClassController.h"
#import "CCBackTransactionAfterClassUpdate.h"
#import "CCClassAddedTransaction.h"

@implementation CCEditClassTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    NSParameterAssert(self.classDataController);
    
    CCUpdateClassController *updateClassController = [CCUpdateClassController new];
    
    CCBackTransactionAfterClassUpdate *backTransaction = [CCBackTransactionAfterClassUpdate new];
    backTransaction.navigation = self.navigation;
    backTransaction.previousController = self.classDataController;
    
    CCClassAddedTransaction *classAddedTransaction = [CCClassAddedTransaction new];
    classAddedTransaction.navigation = self.navigation;
    updateClassController.classAddedTransaction = classAddedTransaction;
    
    updateClassController.backTransaction = backTransaction;
    updateClassController.currentClass = object;
    [self.navigation pushViewController:updateClassController animated:YES];

}

@end
