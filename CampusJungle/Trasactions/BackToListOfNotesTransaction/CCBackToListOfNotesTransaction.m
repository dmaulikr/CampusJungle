//
//  CCBackToListOfNotesTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 09.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCBackToListOfNotesTransaction.h"

@implementation CCBackToListOfNotesTransaction

- (void)perform
{
    NSParameterAssert(self.navigation);
    NSParameterAssert(self.listController);
    
    if([self.navigation.viewControllers containsObject:self.listController]){
        [self.navigation popToViewController:self.listController animated:YES];
    }
}

@end
