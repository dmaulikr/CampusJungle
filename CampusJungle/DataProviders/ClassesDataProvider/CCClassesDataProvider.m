//
//  CCClassesDataProvider.m
//  CampusJungle
//
//  Created by Yulia Petryshena on 5/31/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCClassesDataProvider.h"
#import "CCClassesApiProviderProtocol.h"
#import "CCStandardErrorHandler.h"

@interface CCClassesDataProvider ()

@property (nonatomic, strong) id<CCClassesApiProviderProtocol> ioc_classesApiProvider;

@end

@implementation CCClassesDataProvider

- (void)loadItems
{
    __weak CCClassesDataProvider *weakSelf = self;
    [self.ioc_classesApiProvider getClassesOfCollege:self.collegeId searchString:self.searchQuery successHandler:^(id response) {
        weakSelf.arrayOfItems = response;
        weakSelf.totalNumber = [weakSelf.arrayOfItems count];
        [weakSelf.targetTable reloadData];
        weakSelf.isEverythingLoaded = YES;
    } errorHandler:^(NSError *error) {
        [CCStandardErrorHandler showErrorWithError:error];
    }];
}

@end
