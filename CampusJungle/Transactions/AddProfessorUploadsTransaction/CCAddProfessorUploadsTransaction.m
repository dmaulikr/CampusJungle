//
//  CCAddProfessorUploadsTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 18.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAddProfessorUploadsTransaction.h"
#import "CCAddProfessorUploadsController.h"

@implementation CCAddProfessorUploadsTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    CCAddProfessorUploadsController *addProfessorUploadsController = [CCAddProfessorUploadsController new];
    
    addProfessorUploadsController.currentClass = object;
    
    [self.navigation pushViewController:addProfessorUploadsController animated:YES];
}

@end
