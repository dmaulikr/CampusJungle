//
//  CCBackToUserProfileTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 30.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCBackToUserProfileTransaction.h"
#import "CCEducation.h"

@implementation CCBackToUserProfileTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    NSParameterAssert(self.arrayOfColleges);
    
    if(![self isExistEducation:object]){
        [self.arrayOfColleges addObject:object];
    }
    [self.navigation popToRootViewControllerAnimated:YES];
}

- (BOOL)isExistEducation:(CCEducation *)education
{
    BOOL isAlreadyExist = NO;
    for (CCEducation *existingEducation in self.arrayOfColleges){
        if([existingEducation isEqualToEducation:education]){
            isAlreadyExist = YES;
        }
    }
    return isAlreadyExist;
}

@end
