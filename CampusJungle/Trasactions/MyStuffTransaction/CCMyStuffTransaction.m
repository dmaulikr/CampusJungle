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

@implementation CCMyStuffTransaction

- (void)perform
{
    NSParameterAssert(self.navigation);
    CCMyStuffController *myStuffCOntroller = [CCMyStuffController new];
    
    CCCreateStuffTransaction *creatinStuffTransaction = [CCCreateStuffTransaction new];
    creatinStuffTransaction.navigation = self.navigation;
    myStuffCOntroller.createStuffTransaction = creatinStuffTransaction;
    
    [self.navigation pushViewController:myStuffCOntroller animated:YES];

}

@end
