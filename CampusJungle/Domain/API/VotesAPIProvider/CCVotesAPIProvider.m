//
//  CCVotesAPIProvider.m
//  CampusJungle
//
//  Created by Vlad Korzun on 26.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCVotesAPIProvider.h"

@implementation CCVotesAPIProvider

- (void)loadFeedbackForClassWithID:(NSString *)classID successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler
{
    NSString *path = [NSString stringWithFormat:CCAPIDefines.getFeedback,classID];
    [self loadItemsWithParams:nil path:path successHandler:successHandler errorHandler:errorHandler];
}

- (void)postFeedback:(NSDictionary *)feedback classID:(NSString *)classID successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler
{
    [self setAuthorizationToken];
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    NSString *path = [NSString stringWithFormat:CCAPIDefines.postFeedback,classID];
    [objectManager postObject:nil
                         path:path
                   parameters:feedback
                      success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
                                successHandler(mappingResult);
                            }
                      failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                errorHandler(error);
                            }];
}

- (void)recalculateFeedbackInClassWithID:(NSString *)classID successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler
{
    NSString *path = [NSString stringWithFormat:CCAPIDefines.recalculateFeedback,classID];
    [self setAuthorizationToken];
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [objectManager putObject:nil
                        path:path
                  parameters:nil
                     success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                         successHandler(mappingResult);
                     } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                         errorHandler(error);
                     }];
}

- (void)checkVoitingAvailabilityForClassWithID:(NSString *)classID successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler
{
    NSString *path = [NSString stringWithFormat:CCAPIDefines.votingAvailability,classID];
    [self setAuthorizationToken];
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [objectManager getObject:nil
                        path:path
                  parameters:nil
                     success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                         successHandler(mappingResult);
                     }
                     failure:^(RKObjectRequestOperation *operation, NSError *error) {
                         errorHandler(error);
                     }];
}

@end
