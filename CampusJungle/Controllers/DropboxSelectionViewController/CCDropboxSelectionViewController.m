//
//  CCDropboxSelectionViewController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 04.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCDropboxSelectionViewController.h"
#import "CCDropboxAPIProviderProtocol.h"
#import "CCDefines.h"
#import "CCStandardErrorHandler.h"
#import "CCAlertDefines.h"
#import "CCOrdinaryCell.h"
#import "CCDropboxDataProvider.h"

@interface CCDropboxSelectionViewController ()

@property (nonatomic, strong) id <CCDropboxAPIProviderProtocol> ioc_dropboxAPI;


@end

@implementation CCDropboxSelectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if(![self.ioc_dropboxAPI isLinked]){
        [self.ioc_dropboxAPI linkWithController:self];
    }
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(dropboxLinked)
     name:CCAppDelegateDefines.dropboxLinked
     object:nil];
    
    self.title = CCScreenTitles.dropboxTitle;
    if([self.ioc_dropboxAPI isLinked]){
        [self configTableWithProvider:[CCDropboxDataProvider new] cellClass:[CCOrdinaryCell class]];
    }
}

- (void)dropboxLinked
{
    if(![self.ioc_dropboxAPI isLinked]){
        [CCStandardErrorHandler showErrorWithTitle:CCAlertsMessages.error message:CCAlertsMessages.dropboxLinkingFaild];
    } else {
        [self configTableWithProvider:[CCDropboxDataProvider new] cellClass:[CCOrdinaryCell class]];
    }
}


@end
