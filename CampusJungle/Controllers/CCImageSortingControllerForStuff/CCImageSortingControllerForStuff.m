//
//  CCImageSortingControllerForStuff.m
//  CampusJungle
//
//  Created by Vlad Korzun on 20.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCImageSortingControllerForStuff.h"
#import "CCStuffAPIProviderProtocol.h"

@interface CCImageSortingControllerForStuff ()

@property (nonatomic, strong) id <CCStuffAPIProviderProtocol> ioc_stuffAPIProvider;

@end

@implementation CCImageSortingControllerForStuff

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    return  [super initWithNibName:@"CCImageSortingController" bundle:nibBundleOrNil];
}

- (void)sendFiles
{
    [self saveResultToUploadInfo:self.arrayOfDropboxImages];
//    [self.ioc_notesAPIProvider postDropboxUploadInfo:self.notesUploadInfo successHandler:^(id result) {
//        [self.backToListTransaction perform];
//    } errorHandler:^(NSError *error) {
//        [CCStandardErrorHandler showErrorWithError:error];
//    }];
}

@end
