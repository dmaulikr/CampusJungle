//
//  CCAnswer.m
//  CampusJungle
//
//  Created by Yury Grinenko on 16.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAnswer.h"
#import "CCRestKitConfigurator.h"

@implementation CCAnswer

+ (void)configureMappingWithManager:(RKObjectManager *)objectManager
{
    [self configureRequestMapping:objectManager];
    [self configureResponseMapping:objectManager];
}

+ (void)configureResponseMapping:(RKObjectManager *)objectManager
{
    RKObjectMapping *paginationAnswersResponseMapping = [CCRestKitConfigurator paginationMapping];
    
    RKObjectMapping *questionsMapping = [RKObjectMapping mappingForClass:[CCAnswer class]];
    [questionsMapping addAttributeMappingsFromDictionary:[CCAnswer responseMappingDictionary]];
    
    RKRelationshipMapping *relationShipResponseAnswersMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:CCResponseKeys.items
                                                                                                           toKeyPath:CCResponseKeys.items
                                                                                                         withMapping:questionsMapping];
    
    [paginationAnswersResponseMapping addPropertyMapping:relationShipResponseAnswersMapping];
    
    NSString *pathPattern = [NSString stringWithFormat:CCAPIDefines.loadAnswers, @":answerID"];
    RKResponseDescriptor *responseAnswersDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:paginationAnswersResponseMapping
                                            pathPattern:pathPattern
                                                keyPath:nil
                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [objectManager addResponseDescriptor:responseAnswersDescriptor];
}

+ (void)configureRequestMapping:(RKObjectManager *)objectManager
{
    RKObjectMapping *answerMapping = [RKObjectMapping mappingForClass:[NSMutableDictionary class]];
    [answerMapping addAttributeMappingsFromDictionary:[CCAnswer requestMappingDictionary]];
    RKRequestDescriptor *answerRequestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:answerMapping objectClass:[CCAnswer class] rootKeyPath:nil];
    [objectManager addRequestDescriptor:answerRequestDescriptor];
}

+ (NSDictionary *)responseMappingDictionary
{
    return @{
             @"id" : @"answerId",
             @"question_id" : @"questionId",
             @"text" : @"text",
             @"owner_id" : @"ownerId",
             @"owner_first_name" : @"ownerFirstName",
             @"owner_last_name" : @"ownerLastName",
             @"comments_count" : @"commentsCount",
             @"created_at" : @"createdDate",
             @"likes_count" : @"likesCount",
             @"is_liked" : @"isLiked",
             };
}

+ (NSDictionary *)requestMappingDictionary
{
    return @{
             @"text" : @"text"
             };
}

@end
