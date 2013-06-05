//
//  CCBaseDataProvider.m
//  CampusJungle
//
//  Created by Vlad Korzun on 29.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCBaseDataProvider.h"
#import "CCAlertDefines.h"

@implementation CCBaseDataProvider

- (void)showErrorWhileLoading:(NSError *)error
{
    NSString *errorMessage;
    if(error.code == -1011) {
        errorMessage = CCAlertsMessages.serverUnavailable;
    } else {
        errorMessage = error.localizedDescription;
    }
    
    UIAlertView *alertOnLoadingFaild = [[UIAlertView alloc] initWithTitle:CCAlertsTitles.requestError message:errorMessage delegate:nil cancelButtonTitle:CCAlertsButtons.okButton otherButtonTitles:nil];
    [alertOnLoadingFaild show];
}

- (BOOL)isEmpty
{
    return !self.arrayOfItems.count;
}

- (void)loadMoreItems{}

@end
