//
//  CCReview.m
//  CampusJungle
//
//  Created by Vlad Korzun on 11.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCReview.h"
#import "CCRestKitConfigurator.h"

@implementation CCReview

- (NSString *)modelType
{
    return self.reviewID;
}

+ (void)configureMappingWithManager:(RKObjectManager *)objectManager
{
    [self configureReviewResponse:objectManager];
}

+ (void)configureReviewResponse:(RKObjectManager *)objectManager
{
    RKObjectMapping *paginationReviewResponseMapping = [CCRestKitConfigurator paginationMapping];
    
    RKObjectMapping *reviewMapping = [RKObjectMapping mappingForClass:[CCReview class]];
    [reviewMapping addAttributeMappingsFromDictionary:[CCReview responseMappingDictionary]];
    
    RKRelationshipMapping* relationShipResponseReviewMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:CCResponseKeys.items
                                                                                                           toKeyPath:CCResponseKeys.items
                                                                                                         withMapping:reviewMapping];
    
    [paginationReviewResponseMapping addPropertyMapping:relationShipResponseReviewMapping];
    
    NSString *pathPattern = [NSString stringWithFormat:CCAPIDefines.loadReviews,@":userID"];
    RKResponseDescriptor *responseInboxPaginationMessages =
    [RKResponseDescriptor responseDescriptorWithMapping:paginationReviewResponseMapping
                                            pathPattern:pathPattern
                                                keyPath:nil
                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [objectManager addResponseDescriptor:responseInboxPaginationMessages];
}

+ (NSDictionary *)responseMappingDictionary
{
    return @{
             @"id" : @"reviewID",
             @"text" : @"text",
             @"reviewer_id" : @"reviewerID",
             @"reviewed_id" : @"reviewedID",
             @"rank" : @"rank",
             @"created_at" : @"createdDate"
             };
}

- (NSString *)description
{
    return self.text;
}

@end
