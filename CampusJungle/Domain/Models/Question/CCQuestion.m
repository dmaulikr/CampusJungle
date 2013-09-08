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
    
    NSString *classPathPattern = [NSString stringWithFormat:CCAPIDefines.loadClassQuestions, @":classID"];
    RKResponseDescriptor *responseClassQuestionsDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:paginationQuestionsResponseMapping
                                            pathPattern:classPathPattern
                                                keyPath:nil
                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];

    NSString *groupPathPattern = [NSString stringWithFormat:CCAPIDefines.loadGroupQuestions, @":groupID"];
    RKResponseDescriptor *responseGroupQuestionsDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:paginationQuestionsResponseMapping
                                            pathPattern:groupPathPattern
                                                keyPath:nil
                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];

    
    NSString *loadQuestionPathPattern = [NSString stringWithFormat:CCAPIDefines.loadQuestion, @":questionId"];
    RKResponseDescriptor *loadQuestionDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:questionsMapping
                                            pathPattern:loadQuestionPathPattern
                                                keyPath:@"question"
                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];

    
    [objectManager addResponseDescriptor:responseClassQuestionsDescriptor];
    [objectManager addResponseDescriptor:responseGroupQuestionsDescriptor];
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
             @"class_id" : @"classId",
             @"group_id" : @"groupId",
             @"text" : @"text",
             @"owner_id" : @"ownerId",
             @"attachment" : @"attachment",
             @"answers_count" : @"answersCount",
             @"created_at" : @"createdDate",
             @"owner_first_name" : @"ownerFirstName",
             @"owner_last_name" : @"ownerLastName",
             @"owner_avatar" : @"ownerAvatar",
             @"subject" : @"subject"
             };
}

+ (NSDictionary *)requestMappingDictionary
{
    return @{
             @"text" : @"text",
             @"arrayOfImageUrls" : @"images_urls",
             @"pdfUrl" : @"pdf_url",
             @"subject" : @"subject",
             };
}

- (void)setUploadProgress:(NSNumber *)uploadProgress
{
    _uploadProgress = uploadProgress;
    [self.delegate uploadProgressDidUpdate];
}

@end
