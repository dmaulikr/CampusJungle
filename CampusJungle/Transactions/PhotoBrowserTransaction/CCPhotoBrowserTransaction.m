//
//  CCPhotoBrowserTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 22.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCPhotoBrowserTransaction.h"
#import "CCPhotoBrowserController.h"
#import "CCCloseBrowserTransaction.h"

@implementation CCPhotoBrowserTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    
    CCPhotoBrowserController *photoBrowser = [CCPhotoBrowserController new];
    photoBrowser.dataProvider = object[@"photosProvider"];
    photoBrowser.firstPhoto = object[@"selectedPhoto"];
    
    CCCloseBrowserTransaction *closeBrowserTransaction = [CCCloseBrowserTransaction new];
    closeBrowserTransaction.containerController = self.navigation;
    
    photoBrowser.closeTransaction = closeBrowserTransaction;
    [self.navigation presentViewController:photoBrowser animated:YES completion:nil];
    
}

@end
