//
//  CCUploadImageForStuffController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 20.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCUploadImageForStuffController.h"
#import "MBProgressHUD.h"
#import "CCStuffAPIProvider.h"
#import "CCStandardErrorHandler.h"
#import "CCUploadProcessManagerProtocol.h"

@interface CCUploadImageForStuffController ()

@property (nonatomic, strong) id <CCStuffAPIProviderProtocol> ioc_stuffAPIProvider;
@property (nonatomic, strong) id <CCUploadProcessManagerProtocol> ioc_uploadingManager;

@end

@implementation CCUploadImageForStuffController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    return [super initWithNibName:@"CCUploadImagesController" bundle:nibBundleOrNil];
}

- (void)sendFiles
{
    self.uploadInfo.arrayOfImages = self.dataProvider.arrayOfImages;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Preparing for upload";
    __weak id weakSelf = self;
    CCNoteUploadInfo *uploadInfo = self.uploadInfo;
    id <CCUploadProcessManagerProtocol> uploadManager = self.ioc_uploadingManager;
     [[uploadManager uploadingStuff] addObject:self.uploadInfo];
    [self.ioc_stuffAPIProvider postUploadInfoWithImages:(CCStuffUploadInfo *)self.uploadInfo successHandler:^(id result) {
        [[uploadManager uploadingStuff] removeObject:uploadInfo];
        [uploadManager reloadDelegate];
    } errorHandler:^(NSError *error) {
        [[uploadManager uploadingStuff] removeObject:uploadInfo];
        [uploadManager reloadDelegate];
    } progress:^(double finished) {
        [[weakSelf backToListTransaction] perform];
        uploadInfo.uploadProgress = [NSNumber numberWithDouble:finished];
    }];
}

@end
