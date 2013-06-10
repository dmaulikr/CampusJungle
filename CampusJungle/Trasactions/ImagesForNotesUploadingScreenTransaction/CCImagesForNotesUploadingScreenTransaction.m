//
//  CCImagesForNotesUploadingScreenTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 10.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCImagesForNotesUploadingScreenTransaction.h"
#import "CCUploadImagesController.h"

@implementation CCImagesForNotesUploadingScreenTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.naviation);
    CCUploadImagesController *uploadImagesController = [CCUploadImagesController new];
    uploadImagesController.noteInfo = object;
    [self.naviation pushViewController:uploadImagesController animated:YES];
}

@end
