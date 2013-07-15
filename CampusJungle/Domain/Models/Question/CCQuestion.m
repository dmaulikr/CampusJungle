//
//  CCQuestion.m
//  CampusJungle
//
//  Created by Yury Grinenko on 15.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCQuestion.h"
#import "CCRestKitConfigurator.h"

@implementation CCQuestion

+ (void)configureMappingWithManager:(RKObjectManager *)objectManager
{
    [self configureQuestionsResponse:objectManager];
    [self configureQuestionsRequest:objectManager];
}

+ (void)configureQuestionsResponse:(RKObjectManager *)objectManager
{
    RKObjectMapping *paginationQuestionsResponseMapping = [CCRestKitConfigurator paginationMapping];
    
    RKObjectMapping *questionsMapping = [RKObjectMapping mappingForClass:[CCQuestion class]];
    [questionsMapping addAttributeMappingsFromDictionary:[CCQuestion responseMappingDictionary]];
    
    RKRelationshipMapping *relationShipResponseReviewMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:CCResponseKeys.items
                                                                                                           toKeyPath:CCResponseKeys.items
                                                                                                         withMapping:questionsMapping];
    
    [paginationQuestionsResponseMapping addPropertyMapping:relationShipResponseReviewMapping];
    
    NSString *pathPattern = [NSString stringWithFormat:CCAPIDefines.loadQuestions, @":forumID"];
    RKResponseDescriptor *responseQuestionsDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:paginationQuestionsResponseMapping
                                            pathPattern:pathPattern
                                                keyPath:nil
                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [objectManager addResponseDescriptor:responseQuestionsDescriptor];
}

+ (void)configureQuestionsRequest:(RKObjectManager *)objectManager
{
    RKObjectMapping *questionMapping = [RKObjectMapping mappingForClass:[NSMutableDictionary class]];
    [questionMapping addAttributeMappingsFromDictionary:[CCQuestion requestMappingDictionary]];
    RKRequestDescriptor *questionRequestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:questionMapping objectClass:[CCQuestion class] rootKeyPath:nil];
    [objectManager addRequestDescriptor:questionRequestDescriptor];
}

+ (NSDictionary *)responseMappingDictionary
{
    return @{
             @"id" : @"questionId",
             @"forum_id" : @"forumId",
             @"text" : @"text",
             @"owner_id" : @"ownerId",
             @"attachment" : @"attachment",
             @"answers_count" : @"answersCount",
             };
}

+ (NSDictionary *)requestMappingDictionary
{
    return @{
             @"text" : @"text",
             @"attachment" : @"attachment",
             };
}

@end
