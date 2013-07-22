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
#import "CCBackToListTransaction.h"
#import "CCViewPDFTransaction.h"

@implementation CCProfessorUploadsTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    CCProfessorUploadsController *professorUploads = [CCProfessorUploadsController new];
    
    CCAddProfessorUploadsTransaction *addProfessorUploadsTransaction = [CCAddProfessorUploadsTransaction new];
    CCBackToListTransaction *backToListTransaction = [CCBackToListTransaction new];
    
    CCViewPDFTransaction *viewPdfTransaction = [CCViewPDFTransaction new];
    viewPdfTransaction.navigation = self.navigation;
   
    professorUploads.viewAttachmentTransaction = viewPdfTransaction;
    
    backToListTransaction.navigation = self.navigation;
    backToListTransaction.listController = professorUploads;
    addProfessorUploadsTransaction.backToListTransaction = backToListTransaction;
    
    addProfessorUploadsTransaction.navigation = self.navigation;
    
    professorUploads.addUploadsTransaction = addProfessorUploadsTransaction;
    professorUploads.currentClass = object;
    
    [self.navigation pushViewController:professorUploads animated:YES];

}

@end
