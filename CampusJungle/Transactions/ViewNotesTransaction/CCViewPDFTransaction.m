//
//  CCViewNotesTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 09.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCViewPDFTransaction.h"
#import "CCPdfViewerController.h"

@implementation CCViewPDFTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    CCPdfViewerController *pdfViewer = [CCPdfViewerController new];
    [pdfViewer setPdfUrlString:object];
    [self.navigation pushViewController:pdfViewer animated:YES];
}

@end
