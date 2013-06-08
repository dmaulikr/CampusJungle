//
//  CCDropboxSelectionViewController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 04.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCDropboxImagesSelectionViewController.h"
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
#import "CCNotesAPIProviderProtolcol.h"

@interface CCDropboxImagesSelectionViewController ()

@property (nonatomic, strong) id <CCDropboxAPIProviderProtocol> ioc_dropboxAPI;
@property (nonatomic, strong) CCDropboxDataProvider *dropboxDataProvider;
@property (nonatomic, strong) id <CCNotesAPIProviderProtolcol> ioc_notesAPIProvider;

@end

@implementation CCDropboxImagesSelectionViewController

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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setDoneButtonIfNeeded];
}

- (void)loadTable
{
    self.dropboxDataProvider = [self createDataProvider];
    self.dropboxDataProvider.arrayOfSelectedItems = self.arrayOfSelectedFiles;
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

- (CCDropboxDataProvider *)createDataProvider
{
    return [CCDropboxImageDataProvider new];
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
        NSDictionary *objectForTransaction = @{
                                               @"path" : [self.dropboxDataProvider.dropboxPath stringByAppendingPathComponent:fileInfo.fileData.filename],
                                               @"sellected" : self.arrayOfSelectedFiles,
                                               @"noteInfo" : self.noteUploadInfo
                                               };
        [self.dropboxFileSystemTransaction performWithObject:objectForTransaction];
    } else {
        if([self is:self.arrayOfSelectedFiles containPath:fileInfo.fileData.path]){
            [self removeFrom:self.arrayOfSelectedFiles infoWithPath:fileInfo.fileData.path];
        } else {
            [self.arrayOfSelectedFiles addObject:fileInfo];
        }
    }
    [self setDoneButtonIfNeeded];
}

- (BOOL)is:(NSArray *)array containPath:(NSString *)path
{
    for(CCDropboxFileInfo *info in array){
        if([info.fileData.path isEqualToString:path]){
            return YES;
        }
    }
    return NO;
}

- (void)removeFrom:(NSMutableArray *)array infoWithPath:(NSString *)path
{
    for(CCDropboxFileInfo *info in array){
        if([info.fileData.path isEqualToString:path]){
            [array removeObject:info];
            return;
        }
    }

}

- (void)setDoneButtonIfNeeded
{
    if(self.arrayOfSelectedFiles.count){
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                                  style:UIBarButtonItemStyleBordered
                                                                                 target:self
                                                                                 action:@selector(sendFiles)];
    } else {
        self.navigationItem.rightBarButtonItem = nil;
    }
}

- (void)sendFiles
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.ioc_dropboxAPI checkAllDirectURLForArray:self.arrayOfSelectedFiles successHandler:^(NSArray *selectedFiles) {
        
        self.noteUploadInfo.arrayOfURLs = [CCDropboxFileInfo arrayOfDirectLinksFromArrayOfInfo:selectedFiles];
        
        [self.ioc_notesAPIProvider postDropboxUploadInfo:self.noteUploadInfo successHandler:^(id result) {
            
        } errorHandler:^(NSError *error) {
            
        }];
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
}

@end
