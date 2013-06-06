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
#import "CCDropboxFileInfo.h"
#import "CCDropboxPDFDataProvider.h"
#import "CCDropboxImageDataProvider.h"
#import "MBProgressHUD.h"

@interface CCDropboxSelectionViewController ()

@property (nonatomic, strong) id <CCDropboxAPIProviderProtocol> ioc_dropboxAPI;
@property (nonatomic, strong) CCDropboxDataProvider *dropboxDataProvider;

@end

@implementation CCDropboxSelectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = CCScreenTitles.dropboxTitle;
    
    if(![self.ioc_dropboxAPI isLinked]){
        [self.ioc_dropboxAPI linkWithController:self];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(dropboxLinked)
     name:CCAppDelegateDefines.dropboxLinked
     object:nil];
    
    } else {
        [self loadTable];
    }
}

- (void)loadTable
{
    self.dropboxDataProvider = [CCDropboxImageDataProvider new];
    
    self.dropboxDataProvider.dropboxPath = self.dropboxPath;
    __weak id weakSelf = self;
    self.dropboxDataProvider.providerDidFinishLoading = ^{
        [MBProgressHUD hideAllHUDsForView:[weakSelf view] animated:YES];
    };
    if (![self.dropboxPath isEqualToString:@"/"]){
        NSArray *arrayOfPathComponents = [self.dropboxPath componentsSeparatedByString:@"/"];
        self.title = arrayOfPathComponents.lastObject;
    }
    [self configTableWithProvider:self.dropboxDataProvider cellClass:[CCDropboxCell class]];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)dropboxLinked
{
    if(![self.ioc_dropboxAPI isLinked]){
        [CCStandardErrorHandler showErrorWithTitle:CCAlertsMessages.error message:CCAlertsMessages.dropboxLinkingFaild];
    } else {
        [self.ioc_dropboxAPI createRestCliet];
        [self loadTable];
    }
}

- (void)didSelectedCellWithObject:(id)cellObject
{
    CCDropboxFileInfo *fileInfo = (CCDropboxFileInfo *)cellObject;
    if(fileInfo.fileData.isDirectory){
        [self.dropboxFileSystemTransaction performWithObject:[self.dropboxDataProvider.dropboxPath stringByAppendingPathComponent:fileInfo.fileData.filename]];
    }
}

@end
