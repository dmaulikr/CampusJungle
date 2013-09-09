//
//  CCAnswersApiProvider.m
//  CampusJungle
//
//  Created by Yury Grinenko on 16.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAnswersApiProvider.h"
#import "CCAnswer.h"

static const NSInteger kItemsPerPage = 10;

@implementation CCAnswersApiProvider

- (void)loadAnswersForQuestionWithId:(NSString *)questionId filterString:(NSString *)filterString pageNumber:(NSInteger)pageNumber successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler
{
    NSMutableDictionary *params = [NSMutableDictionary new];
    
    [params setObject:@(pageNumber) forKey:@"page_number"];
    [params setObject:@(kItemsPerPage) forKey:@"per_page"];
    if ([filterString length] > 0) {
        [params setObject:filterString forKey:@"keywords"];
    }
    
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [self setAuthorizationToken];
    NSString *path = [NSString stringWithFormat:CCAPIDefines.loadAnswers, questionId];
    [objectManager getObjectsAtPath:path parameters:params success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        successHandler(mappingResult.firstObject);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        errorHandler(error);
    }];
}

- (void)postAnswer:(CCAnswer *)answer successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler
{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [self setAuthorizationToken];
    NSString *path = [NSString stringWithFormat:CCAPIDefines.postAnswer, answer.questionId];
    [objectManager postObject:answer path:path parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        successHandler(mappingResult.firstObject);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        errorHandler(error);
    }];
}

- (void)postUploadInfoWithImages:(CCAnswer *)answer withImages:(NSArray *)images successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler progress:(progressBlock)progressBlock
{
    NSString *path = [NSString stringWithFormat:CCAPIDefines.postAnswer, answer.questionId];
    
    [self postInfoWithObject:answer
                   thumbnail:nil
                      images:images
                      onPath:path
              successHandler:successHandler
                errorHandler:errorHandler
                    progress:progressBlock];
}

- (void)deleteAnswer:(CCAnswer *)answer successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler
{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [self setAuthorizationToken];
    NSString *path = [NSString stringWithFormat:CCAPIDefines.deleteAnswer, answer.answerId];
    [objectManager deleteObject:nil path:path parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        successHandler(mappingResult);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        errorHandler(error);
    }];
}

- (void)likeAnswer:(CCAnswer *)answer successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler
{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [self setAuthorizationToken];
    NSString *path = [NSString stringWithFormat:CCAPIDefines.likeAnswer, answer.answerId];
    [objectManager postObject:nil path:path parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        successHandler(mappingResult.firstObject);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        errorHandler(error);
    }];
}

- (void)loadAnswerWithId:(NSString *)answerId successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler
{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [self setAuthorizationToken];
    NSString *path = [NSString stringWithFormat:CCAPIDefines.loadAnswer, answerId];
    [objectManager getObject:nil path:path parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        successHandler(mappingResult.firstObject);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        errorHandler(error);
    }];
}

- (void)emailAttachmentOfAnswer:(CCAnswer *)answer successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler
{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [self setAuthorizationToken];
    NSString *path = [NSString stringWithFormat:CCAPIDefines.answerAttachmentSendUsingEmail,answer.answerId];
    [objectManager getObject:nil
                        path:path
                  parameters:nil
                     success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                         successHandler(mappingResult.firstObject);
                     }
                     failure:^(RKObjectRequestOperation *operation, NSError *error) {
                         errorHandler(error);
                     }];
}

@end
