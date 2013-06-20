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

@interface CCUploadImageForStuffController ()

@property (nonatomic, strong) id <CCStuffAPIProviderProtocol> ioc_stuffAPIProvider;

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
    [self.ioc_stuffAPIProvider postUploadInfoWithImages:(CCStuffUploadInfo *)self.uploadInfo successHandler:^(id result) {
        
    } errorHandler:^(NSError *error) {
        [CCStandardErrorHandler showErrorWithError:error];
    } progress:^(double finished) {
        [[weakSelf backToListTransaction] perform];
        NSLog(@"%0.0lf",finished * 100);
    }];
}

@end
