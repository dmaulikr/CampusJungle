//
//  CCProfessorUploadsController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 18.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCProfessorUploadsController.h"
#import "CCNavigationBarViewHelper.h"
#import "CCProfessorUploadDataProvider.h"
#import "CCProfessorUploadsAPIProviderProtocol.h"
#import "CCProfessorUploadsCell.h"
#import "CCAlertHelper.h"
#import "CCStandardErrorHandler.h"


@interface CCProfessorUploadsController ()

@property (nonatomic, strong) id <CCProfessorUploadsAPIProviderProtocol> ioc_professorUploadsAPIProvider;
@property (nonatomic, strong) CCProfessorUploadDataProvider *dataProvider;

@end

@implementation CCProfessorUploadsController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [CCNavigationBarViewHelper plusButtonWithTarget:self action:@selector(addUploads)];
    self.title = @"Prof. Uploads";
    [self setupTableView];
}

- (void)addUploads
{
    [self.addUploadsTransaction performWithObject:self.currentClass];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.dataProvider loadItems];
}

- (void)setupTableView
{
    self.dataProvider = [CCProfessorUploadDataProvider new];
    self.dataProvider.delegate = self;
    [self.dataProvider setClassID:self.currentClass.classID];
    [self configTableWithProvider:self.dataProvider cellClass:[CCProfessorUploadsCell class]];
}

- (BOOL)isNeedToLeftSelected
{
    return NO;
}

- (void)deleteUploads:(CCProfessorUpload *)upload
{
    __weak CCProfessorUploadsController *weakSelf = self;
    [CCAlertHelper showConfirmWithSuccess:^{
        [self.ioc_professorUploadsAPIProvider deleteUploadInfo:upload
                                                successHandler:^(RKMappingResult *result) {
                                                    [SVProgressHUD showSuccessWithStatus:CCSuccessMessages.deleteUploads
                                                                                duration:CCProgressHudsConstants.loaderDuration];
                                                    [weakSelf.dataProvider loadItems];
                                                } errorHandler:^(NSError *error) {
                                                    [CCStandardErrorHandler showErrorWithError:error];
                                                }];
    }];
}

- (void)emailAttachmentOfUploads:(CCProfessorUpload *)upload
{
    [self.ioc_professorUploadsAPIProvider emailAttachmentOfUpload:upload
                                                   successHandler:^(id result) {
                                                       [SVProgressHUD showSuccessWithStatus:CCSuccessMessages.uploadsAttachmentEmailed duration:CCProgressHudsConstants.loaderDuration];
                                                   } errorHandler:^(NSError *error) {
                                                       [CCStandardErrorHandler showErrorWithError:error];
                                                   }];
}

- (void)viewAttachmentOfUplads:(CCProfessorUpload *)upload
{
    [self.viewAttachmentTransaction performWithObject:upload.attachment];
}


@end
