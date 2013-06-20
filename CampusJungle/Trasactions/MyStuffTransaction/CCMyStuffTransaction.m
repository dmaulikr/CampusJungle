//
//  CCMyStuffTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 20.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCMyStuffTransaction.h"
#import "CCMyStuffController.h"
#import "CCCreateStuffTransaction.h"
#import "CCBackToListOfNotesTransaction.h"

@implementation CCMyStuffTransaction

- (void)perform
{
    NSParameterAssert(self.navigation);
    CCMyStuffController *myStuffController = [CCMyStuffController new];
    
    CCCreateStuffTransaction *creationStuffTransaction = [CCCreateStuffTransaction new];
    creationStuffTransaction.navigation = self.navigation;
    myStuffController.createStuffTransaction = creationStuffTransaction;

    
    CCBackToListOfNotesTransaction *backToListTransaction = [CCBackToListOfNotesTransaction new];
    backToListTransaction.navigation = self.navigation;
    backToListTransaction.listController = myStuffController;
    
    creationStuffTransaction.backToListTransaction = backToListTransaction;
    
    [self.navigation pushViewController:myStuffController animated:YES];

}

@end
