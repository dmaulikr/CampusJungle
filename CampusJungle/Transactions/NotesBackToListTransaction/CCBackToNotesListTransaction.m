//
//  CCBackToNotesListTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 19.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCBackToNotesListTransaction.h"

@implementation CCBackToNotesListTransaction

- (void)perform
{
    NSParameterAssert(self.navigation);
    [self.navigation popViewControllerAnimated:YES];
}

@end
