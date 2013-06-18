//
//  CCMarketAPIProvider.m
//  CampusJungle
//
//  Created by Vlad Korzun on 13.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCMarketAPIProvider.h"
#import "CCDefines.h"

@implementation CCMarketAPIProvider

- (void)loadNotesNumberOfPage:(NSNumber *)pageNumber filters:(NSDictionary *)filters order:(NSString *)order query:(NSString *)query successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler
{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [self setAuthorizationToken];
    NSMutableDictionary *params = [@{
                             @"filters" : filters,
                             @"order" : order,
                             } mutableCopy];
    if(query){
        [params setValue:query forKey:@"keywords"];
    }
    
    [objectManager getObject:nil
                         path:CCAPIDefines.notesInMarket
                   parameters:params
                      success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                          successHandler(mappingResult.firstObject);
                      }
                      failure:^(RKObjectRequestOperation *operation, NSError *error) {
                          errorHandler(error);
                      }];
}

- (void)performPurchase:(NSString *)noteID
             fullAccess:(BOOL)fullAccess
         successHandler:(successHandlerWithRKResult)successHandler
           errorHandler:(errorHandler)errorHandler
{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [self setAuthorizationToken];
    NSDictionary *params;
    if(fullAccess){
        params = @{@"full_access" : @"true"};
    } else {
        params = @{@"full_access" : @"false"};
    }
    NSString *path = [NSString stringWithFormat:CCAPIDefines.purchaseNote,noteID];
    [objectManager postObject:nil
                         path:path
                   parameters:params
                      success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                          successHandler(mappingResult);
} failure:^(RKObjectRequestOperation *operation, NSError *error) {
    errorHandler(error);
}];

}

@end
