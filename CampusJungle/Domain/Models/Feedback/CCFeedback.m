//
//  CCFeedback.m
//  CampusJungle
//
//  Created by Vlad Korzun on 26.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCFeedback.h"
#import "CCRestKitConfigurator.h"

@implementation CCFeedback

+ (void)configureMappingWithManager:(RKObjectManager *)objectManager
{
    [self configureFeedbackResponse:objectManager];
}

+ (void)configureFeedbackResponse:(RKObjectManager *)objectManager
{
   
    RKObjectMapping *feedbackMapping = [RKObjectMapping mappingForClass:[CCFeedback class]];
    
    [feedbackMapping addAttributeMappingsFromDictionary:[CCFeedback responseMappingDictionary]];
    
   ;
    NSString *feedbackPathPatern = [NSString stringWithFormat:CCAPIDefines.getFeedback,@":classID"];
    RKResponseDescriptor *responseFeedback =
    [RKResponseDescriptor responseDescriptorWithMapping:feedbackMapping
                                            pathPattern:feedbackPathPatern
                                                keyPath:@"feedback"
                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [objectManager addResponseDescriptor:responseFeedback];
    
    
    NSString *feedbackRecalculatePathPatern = [NSString stringWithFormat:CCAPIDefines.recalculateFeedback,@":classID"];
    RKResponseDescriptor *responseRecalculateFeedback =
    [RKResponseDescriptor responseDescriptorWithMapping:feedbackMapping
                                            pathPattern:feedbackRecalculatePathPatern
                                                keyPath:@"feedback"
                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [objectManager addResponseDescriptor:responseRecalculateFeedback];
    [objectManager addResponseDescriptor:responseFeedback];

    
    RKObjectMapping *availabilityMapping = [RKObjectMapping mappingForClass:[NSMutableDictionary class]];
    [availabilityMapping addAttributeMappingsFromDictionary:@{@"availability" : @"availability"}];
    NSString *availabilityPathPatern = [NSString stringWithFormat:CCAPIDefines.votingAvailability,@":classID"];
    
    RKResponseDescriptor *responseAvailability =
    [RKResponseDescriptor responseDescriptorWithMapping:availabilityMapping
                                            pathPattern:availabilityPathPatern
                                                keyPath:nil
                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [objectManager addResponseDescriptor:responseAvailability];

    
}

+ (NSDictionary *)responseMappingDictionary
{
    return @{
             @"total_statistics" : @"total_statistics",
             @"current_statistics" : @"current_statistics",
             @"klass_id" : @"classID"
             };
}

@end
