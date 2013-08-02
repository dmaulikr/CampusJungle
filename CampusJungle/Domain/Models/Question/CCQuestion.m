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

- (NSString *)modelType
{
    return CCModelsTypes.question;
}

- (NSString *)modelID
{
    return self.questionId;
}

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
    
    RKRelationshipMapping *relationShipResponseQuestionsMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:CCResponseKeys.items
                                                                                                           toKeyPath:CCResponseKeys.items
                                                                                                         withMapping:questionsMapping];
    [paginationQuestionsResponseMapping addPropertyMapping:relationShipResponseQuestionsMapping];
    
    NSString *pathPattern = [NSString stringWithFormat:CCAPIDefines.loadQuestions, @":forumID"];
    RKResponseDescriptor *responseQuestionsDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:paginationQuestionsResponseMapping
                                            pathPattern:pathPattern
                                                keyPath:nil
                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];

    NSString *loadQuestionPathPattern = [NSString stringWithFormat:CCAPIDefines.loadQuestion, @":questionId"];
    RKResponseDescriptor *loadQuestionDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:questionsMapping
                                            pathPattern:loadQuestionPathPattern
                                                keyPath:@"question"
                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];

    
    [objectManager addResponseDescriptor:responseQuestionsDescriptor];
    [objectManager addResponseDescriptor:loadQuestionDescriptor];
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
             @"created_at" : @"createdDate",
             @"owner_first_name" : @"ownerFirstName",
             @"owner_last_name" : @"ownerLastName",
             @"owner_avatar" : @"ownerAvatar",
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

- (void)setUploadProgress:(NSNumber *)uploadProgress
{
    _uploadProgress = uploadProgress;
    [self.delegate uploadProgressDidUpdate];
}

@end
