//
//  CCMyBooksDataProvider.m
//  CampusJungle
//
//  Created by Vlad Korzun on 06.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCMyBooksDataProvider.h"
#import "CCBooksAPIProviderProtocol.h"
#import "CCUploadProcessManagerProtocol.h"
#import "CCStandardErrorHandler.h"

@interface CCMyBooksDataProvider()


@property (nonatomic, strong) id <CCBooksAPIProviderProtocol> ioc_BookAPIProvider;
@property (nonatomic, strong) id <CCUploadProcessManagerProtocol> ioc_uploadManager;

@end

@implementation CCMyBooksDataProvider

- (void)loadItemsForPageNumber:(long)numberOfPage successHandler:(successWithObject)successHandler
{
    [self.ioc_BookAPIProvider loadMyBookNumberOfPage:[NSNumber numberWithLong:numberOfPage] query:self.searchQuery successHandler:^(RKMappingResult *result) {
        
        if([[self.ioc_uploadManager uploadingBooks] count]){
            [self.ioc_uploadManager setCurrentDataProvider:self];
            NSMutableArray *allNotes = [NSMutableArray arrayWithArray:[self.ioc_uploadManager uploadingBooks]];
            [allNotes addObjectsFromArray:result.firstObject[@"items"]];
            result.firstObject[@"items"] = allNotes;
            successHandler(result.firstObject);
        } else {
            successHandler(result.firstObject);
        }
        
    } errorHandler:^(NSError *error) {
        [CCStandardErrorHandler showErrorWithError:error];
    }];
}

@end
