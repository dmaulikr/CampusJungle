//
//  CCProfessorUploadsTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 18.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCProfessorUploadsTransaction.h"
#import "CCProfessorUploadsController.h"
#import "CCAddProfessorUploadsTransaction.h"

@implementation CCProfessorUploadsTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    CCProfessorUploadsController *professorUploads = [CCProfessorUploadsController new];
    
    CCAddProfessorUploadsTransaction *addProfessorUploadsTransaction = [CCAddProfessorUploadsTransaction new];
    addProfessorUploadsTransaction.navigation = self.navigation;
    
    professorUploads.addUploadsTransaction = addProfessorUploadsTransaction;
    professorUploads.currentClass = object;
    
    [self.navigation pushViewController:professorUploads animated:YES];

}

@end
