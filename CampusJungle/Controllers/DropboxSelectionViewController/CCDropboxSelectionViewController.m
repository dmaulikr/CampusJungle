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
#import "CCDropboxCell.h"
#import "CCDropboxDataProvider.h"
#import <DropboxSDK/DropboxSDK.h>
#import "CCDropboxFileInfo.h"

@interface CCDropboxSelectionViewController ()

@property (nonatomic, strong) id <CCDropboxAPIProviderProtocol> ioc_dropboxAPI;
@property (nonatomic, strong) CCDropboxDataProvider *dropboxDataProvider;

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
    self.dropboxDataProvider = [CCDropboxDataProvider new];
    self.dropboxDataProvider.dropboxPath = self.dropboxPath;
    if([self.ioc_dropboxAPI isLinked]){
        [self configTableWithProvider:self.dropboxDataProvider cellClass:[CCDropboxCell class]];
    }
}

- (void)dropboxLinked
{
    if(![self.ioc_dropboxAPI isLinked]){
        [CCStandardErrorHandler showErrorWithTitle:CCAlertsMessages.error message:CCAlertsMessages.dropboxLinkingFaild];
    } else {
        [self configTableWithProvider:[CCDropboxDataProvider new] cellClass:[CCDropboxCell class]];
    }
}

- (void)didSelectedCellWithObject:(id)cellObject
{
    CCDropboxFileInfo *fileInfo = (CCDropboxFileInfo *)cellObject;
    if(fileInfo.fileData.isDirectory){
        [self.dropboxFileSystemTransaction performWithObject:[self.dropboxDataProvider.dropboxPath stringByAppendingFormat:@"%@/",fileInfo.fileData.filename]];
    }

}

@end
