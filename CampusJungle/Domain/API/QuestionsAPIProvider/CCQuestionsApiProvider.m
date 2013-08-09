//
//  CCQuestionsApiProvider.m
//  CampusJungle
//
//  Created by Yury Grinenko on 15.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCQuestionsApiProvider.h"

@implementation CCQuestionsApiProvider

- (void)loadQuestionsForClassWithId:(NSString *)classId filterString:(NSString *)filterString pageNumber:(NSInteger)pageNumber successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler
{
    NSMutableDictionary *params = [NSMutableDictionary new];
    
    [params setObject:@(pageNumber) forKey:@"page_number"];
    if ([filterString length] > 0) {
        [params setObject:filterString forKey:@"keywords"];
    }
    
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [self setAuthorizationToken];
    NSString *path = [NSString stringWithFormat:CCAPIDefines.loadClassQuestions, classId];
    [objectManager getObjectsAtPath:path parameters:params success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        successHandler(mappingResult.firstObject);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        errorHandler(error);
    }];
}

- (void)loadQuestionsForGroupWithId:(NSString *)groupId filterString:(NSString *)filterString pageNumber:(NSInteger)pageNumber successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler
{
    NSMutableDictionary *params = [NSMutableDictionary new];
    
    [params setObject:@(pageNumber) forKey:@"page_number"];
    if ([filterString length] > 0) {
        [params setObject:filterString forKey:@"keywords"];
    }
    
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [self setAuthorizationToken];
    NSString *path = [NSString stringWithFormat:CCAPIDefines.loadGroupQuestions, groupId];
    [objectManager getObjectsAtPath:path parameters:params success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        successHandler(mappingResult.firstObject);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        errorHandler(error);
    }];    
}

- (void)postQuestion:(CCQuestion *)question successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler
{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [self setAuthorizationToken];
    NSString *path;
    if ([question.classId length] > 0) {
        path = [NSString stringWithFormat:CCAPIDefines.postClassQuestion, question.classId];
    }
    else {
        path = [NSString stringWithFormat:CCAPIDefines.postGroupQuestion, question.groupId];
    }
    [objectManager postObject:question path:path parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        successHandler(mappingResult.firstObject);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        errorHandler(error);
    }];
}

- (void)deleteQuestion:(CCQuestion *)question successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler
{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [self setAuthorizationToken];
    NSString *path = [NSString stringWithFormat:CCAPIDefines.deleteQuestion, question.questionId];
    [objectManager deleteObject:nil path:path parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        successHandler(mappingResult);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        errorHandler(error);
    }];
}

- (void)postUploadInfoWithImages:(CCQuestion *)question withImages:(NSArray *)images successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler progress:(progressBlock)progressBlock
{
    NSString *path;
    if ([question.classId length] > 0) {
        path = [NSString stringWithFormat:CCAPIDefines.postClassQuestion, question.classId];
    }
    else {
        path = [NSString stringWithFormat:CCAPIDefines.postGroupQuestion, question.groupId];
    }
    [self postInfoWithObject:question
                  thumbnail:nil
                     images:images
                     onPath:path
             successHandler:successHandler
               errorHandler:errorHandler
                   progress:progressBlock];
}

- (void)emailAttachmentOfQuestion:(CCQuestion *)question successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler
{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [self setAuthorizationToken];

    NSString *path = [NSString stringWithFormat:CCAPIDefines.emailQuestionAttachment, question.questionId];
    [objectManager putObject:nil path:path parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        successHandler(mappingResult);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        errorHandler(error);
    }];
}

- (void)loadQuestionWithId:(NSString *)questionId successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler
{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [self setAuthorizationToken];
    NSString *path = [NSString stringWithFormat:CCAPIDefines.loadQuestion, questionId];
    [objectManager getObject:nil path:path parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        successHandler(mappingResult.firstObject);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        errorHandler(error);
    }];
}

@end
