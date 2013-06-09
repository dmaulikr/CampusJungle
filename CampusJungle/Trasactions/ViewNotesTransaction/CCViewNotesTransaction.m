//
//  CCViewNotesTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 09.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCViewNotesTransaction.h"
#import "CCNotesViewerController.h"

@implementation CCViewNotesTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    CCNotesViewerController *noteViewer = [CCNotesViewerController new];
    noteViewer.noteForDisplay = object;
    [self.navigation pushViewController:noteViewer animated:YES];
}

@end
