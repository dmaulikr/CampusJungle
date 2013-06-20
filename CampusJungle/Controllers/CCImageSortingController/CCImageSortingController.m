//
//  CCImageSortingController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 10.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCImageSortingController.h"
#import "CCImageSortingDataSource.h"
#import "CCImageSortingDataProvider.h"
#import "CCDropboxCell.h"
#import "CCNotesAPIProviderProtolcol.h"
#import "CCStandardErrorHandler.h"

@interface CCImageSortingController ()

@property (nonatomic, strong) id <CCNotesAPIProviderProtolcol> ioc_notesAPIProvider;

@end

@implementation CCImageSortingController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataSourceClass = [CCImageSortingDataSource class];
    CCImageSortingDataProvider *dataProvider = [CCImageSortingDataProvider new];
    dataProvider.arrayOfDropboxImages = self.arrayOfDropboxImages;
    [self configTableWithProvider:dataProvider cellClass:[CCDropboxCell class]];
    self.mainTable.editing = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self setDoneButtonIfNeeded];
}

- (void)setDoneButtonIfNeeded
{
    if(self.arrayOfDropboxImages.count){
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
    [self saveResultToUploadInfo:self.arrayOfDropboxImages];
    [self.ioc_notesAPIProvider postDropboxUploadInfo:self.uploadInfo successHandler:^(id result) {
        [self.backToListTransaction perform];
    } errorHandler:^(NSError *error) {
        [CCStandardErrorHandler showErrorWithError:error];
    }];
}

- (void)didUpdate
{
    [self setDoneButtonIfNeeded];
}

- (void)saveResultToUploadInfo:(NSArray *)selectedFiles
{
    self.uploadInfo.arrayOfURLs = [CCDropboxFileInfo arrayOfDirectLinksFromArrayOfInfo:selectedFiles];
}


@end
