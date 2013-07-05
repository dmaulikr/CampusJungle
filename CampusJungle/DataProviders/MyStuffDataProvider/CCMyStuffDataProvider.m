//
//  CCMyStuffDataProvider.m
//  CampusJungle
//
//  Created by Vlad Korzun on 20.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCMyStuffDataProvider.h"
#import "CCStuffAPIProviderProtocol.h"
#import "CCStandardErrorHandler.h"
#import "CCUploadProcessManagerProtocol.h"

@interface CCMyStuffDataProvider()

@property (nonatomic, strong) id <CCStuffAPIProviderProtocol> ioc_stuffAPIProvider;
@property (nonatomic, strong) id <CCUploadProcessManagerProtocol> ioc_uploadManager;

@end

@implementation CCMyStuffDataProvider

- (void)loadItemsForPageNumber:(long)numberOfPage successHandler:(successWithObject)successHandler
{
    [self.ioc_stuffAPIProvider loadMyStuffNumberOfPage:[NSNumber numberWithLong:numberOfPage] query:self.searchQuery successHandler:^(RKMappingResult *result) {
      
        if([[self.ioc_uploadManager uploadingStuff] count]){
            [self.ioc_uploadManager setCurrentDataProvider:self];
            NSMutableArray *allNotes = [NSMutableArray arrayWithArray:[self.ioc_uploadManager uploadingStuff]];
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
