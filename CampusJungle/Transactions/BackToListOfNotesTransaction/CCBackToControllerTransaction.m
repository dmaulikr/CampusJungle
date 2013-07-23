//
//  CCBackToListOfNotesTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 09.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCBackToControllerTransaction.h"

@implementation CCBackToControllerTransaction

- (void)perform
{
    NSParameterAssert(self.navigation);
    NSParameterAssert(self.targetController);
    
    if([self.navigation.viewControllers containsObject:self.targetController]){
        [self.navigation popToViewController:self.targetController animated:YES];
    }
}

@end
