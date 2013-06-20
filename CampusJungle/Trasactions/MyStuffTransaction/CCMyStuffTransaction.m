//
//  CCMyStuffTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 20.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCMyStuffTransaction.h"
#import "CCMyStuffController.h"

@implementation CCMyStuffTransaction

- (void)perform
{
    NSParameterAssert(self.navigation);
    CCMyStuffController *myStuffCOntroller = [CCMyStuffController new];
    
    [self.navigation pushViewController:myStuffCOntroller animated:YES];

}

@end
