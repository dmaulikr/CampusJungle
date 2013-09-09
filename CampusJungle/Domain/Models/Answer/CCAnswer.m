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

- (NSString *)modelID
{
    return self.answerId;
}

- (NSString *)modelType
{
    return CCModelsTypes.answer;
}

+ (CCAnswer *)answerWithText:(NSString *)text
{
    CCAnswer *answer = [CCAnswer new];
    [answer setText:text];
    return answer;
}

+ (void)configureMappingWithManager:(RKObjectManager *)objectManager
{
    [self configureRequestMapping:objectManager];
    [self configureResponseMapping:objectManager];
}

+ (void)configureResponseMapping:(RKObjectManager *)objectManager
{
    RKObjectMapping *paginationAnswersResponseMapping = [CCRestKitConfigurator paginationMapping];
    
    RKObjectMapping *answersMapping = [RKObjectMapping mappingForClass:[CCAnswer class]];
    [answersMapping addAttributeMappingsFromDictionary:[CCAnswer responseMappingDictionary]];
    
    RKRelationshipMapping *relationShipResponseAnswersMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:CCResponseKeys.items
                                                                                                           toKeyPath:CCResponseKeys.items
                                                                                                         withMapping:answersMapping];
    
    [paginationAnswersResponseMapping addPropertyMapping:relationShipResponseAnswersMapping];
    
    NSString *pathPattern = [NSString stringWithFormat:CCAPIDefines.loadAnswers, @":answerID"];
    RKResponseDescriptor *responseAnswersDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:paginationAnswersResponseMapping
                                            pathPattern:pathPattern
                                                keyPath:nil
                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    NSString *loadAnswerPathPattern = [NSString stringWithFormat:CCAPIDefines.loadAnswer, @":answerId"];
    RKResponseDescriptor *loadAnswersDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:answersMapping
                                            pathPattern:loadAnswerPathPattern
                                                keyPath:@"answer"
                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];

    
    [objectManager addResponseDescriptor:responseAnswersDescriptor];
    [objectManager addResponseDescriptor:loadAnswersDescriptor];
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
             @"attachment" : @"attachment",
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
             @"text" : @"text",
             
             @"arrayOfImageUrls" : @"images_urls",
             @"pdfUrl" : @"pdf_url",
             };
}

@end
