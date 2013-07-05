//
//  CCMyNotesDataProvider.m
//  CampusJungle
//
//  Created by Vlad Korzun on 07.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCMyNotesDataProvider.h"
#import "CCUploadProcessManagerProtocol.h"

@interface CCMyNotesDataProvider()

@property (nonatomic, strong) id <CCUploadProcessManagerProtocol> ioc_uploadManager;

@end

@implementation CCMyNotesDataProvider

- (void)loadItemsForPageNumber:(long)numberOfPage successHandler:(successWithObject)successHandler
{
    [self.ioc_apiProvider loadMyNotesNumberOfPage:[NSNumber numberWithLong:numberOfPage] query:self.searchQuery successHandler:^(RKMappingResult *result) {
        if([[self.ioc_uploadManager uploadingNotes] count]){
            [self.ioc_uploadManager setCurrentDataProvider:self];
            NSMutableArray *allNotes = [NSMutableArray arrayWithArray:[self.ioc_uploadManager uploadingNotes]];
            [allNotes addObjectsFromArray:result.firstObject[@"items"]];
            result.firstObject[@"items"] = allNotes;
            successHandler(result.firstObject);
        } else {
            successHandler(result.firstObject);
        }
    } errorHandler:^(NSError *error) {
        [self showErrorWhileLoading:error];
    }];
}

@end
