//
//  CCBookDetailsController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 06.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCBookDetailsController.h"
#import "CCAlertHelper.h"
#import "CCBooksAPIProviderProtocol.h"
#import "CCBook.h"
#import "CCStandardErrorHandler.h"

@interface CCBookDetailsController ()

@property (nonatomic, strong) id <CCBooksAPIProviderProtocol> ioc_bookAPIProvider;

@end

@implementation CCBookDetailsController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Book Details";
}

- (void)deleteStuffButtonDidPressed:(id)sender
{
    __weak CCBookDetailsController *weakSelf = self;
    [CCAlertHelper showWithMessage:CCAlertsMessages.deleteBook success:^{
        [weakSelf.ioc_bookAPIProvider deleteBookWithId:[(CCBook *)weakSelf.stuff bookID] successHandler:^(RKMappingResult *result) {
            [SVProgressHUD showSuccessWithStatus:CCSuccessMessages.deleteBook duration:CCProgressHudsConstants.loaderDuration];
            [weakSelf.backTransaction perform];
        } errorHandler:^(NSError *error) {
            [CCStandardErrorHandler showErrorWithError:error];
        }];
    }];
}

@end
