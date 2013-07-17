//
//  CCPurchasedNotesDataProvider.m
//  CampusJungle
//
//  Created by Vlad Korzun on 17.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCPurchasedNotesDataProvider.h"
#import "CCNotesAPIProviderProtolcol.h"

@interface CCPurchasedNotesDataProvider()

@property (nonatomic, strong) id <CCNotesAPIProviderProtolcol> ioc_notesApiProvider;

@end

@implementation CCPurchasedNotesDataProvider

- (void)loadItemsForPageNumber:(long)numberOfPage successHandler:(successWithObject)successHandler
{
    [self.ioc_notesApiProvider loadPurchasedNotesSearchQuery:self.searchQuery
                                                  PageNumber:@(numberOfPage)
                                             successHandler:^(RKMappingResult *result) {
        successHandler(result.firstObject);
    } errorHandler:^(NSError *error) {
        [self showErrorWhileLoading:error];
    }];
    
}

@end
