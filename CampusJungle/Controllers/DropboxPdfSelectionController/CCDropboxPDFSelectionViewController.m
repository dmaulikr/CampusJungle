//
//  CCDropboxPDFSelectionViewController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 09.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCDropboxPDFSelectionViewController.h"
#import "CCDropboxAPIProviderProtocol.h"
#import "CCDefines.h"
#import "CCStandardErrorHandler.h"
#import "CCDropboxCell.h"
#import "CCDropboxDataProvider.h"
#import "CCDropboxFileInfo.h"
#import "CCDropboxPDFDataProvider.h"
#import "CCDropboxImageDataProvider.h"
#import "MBProgressHUD.h"
#import "CCNotesAPIProviderProtolcol.h"

@interface CCDropboxPDFSelectionViewController ()

@end

@implementation CCDropboxPDFSelectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    return [super initWithNibName:@"CCDropboxImagesSelectionViewController" bundle:nibBundleOrNil];

}

- (CCDropboxDataProvider *)createDataProvider
{
    return [CCDropboxPDFDataProvider new];
}

- (void)didSelectedCellWithObject:(id)cellObject
{
    CCDropboxFileInfo *fileInfo = (CCDropboxFileInfo *)cellObject;
    if(fileInfo.fileData.isDirectory){
        NSDictionary *objectForTransaction = @{
                                               @"path" : [self.dropboxDataProvider.dropboxPath stringByAppendingPathComponent:fileInfo.fileData.filename],
                                               @"sellected" : self.arrayOfSelectedFiles,
                                               };
        [self.dropboxFileSystemTransaction performWithObject:objectForTransaction];
    } else {
        if([self is:self.arrayOfSelectedFiles containPath:fileInfo.fileData.path]){
            [self removeFrom:self.arrayOfSelectedFiles infoWithPath:fileInfo.fileData.path];
        } else {
            [self cleanSelection];
            [self.arrayOfSelectedFiles addObject:fileInfo];
        }
    }
    [self setDoneButtonIfNeeded];
}

- (void)cleanSelection
{
    if(self.arrayOfSelectedFiles.count == 0){
        return;
    }
    
    CCDropboxFileInfo *privSelected = self.arrayOfSelectedFiles.lastObject;
    privSelected.isSelected = NO;
    [self.arrayOfSelectedFiles removeAllObjects];
    [self.mainTable reloadData];
}

- (void)sendFiles
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.ioc_dropboxAPI checkAllDirectURLForArray:self.arrayOfSelectedFiles successHandler:^(NSArray *selectedFiles) {
        self.uploadingBlock([CCDropboxFileInfo arrayOfDirectLinksFromArrayOfInfo:selectedFiles]);
    }];
}

@end
