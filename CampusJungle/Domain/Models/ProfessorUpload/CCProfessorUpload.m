//
//  CCProfessorUpload.m
//  CampusJungle
//
//  Created by Vlad Korzun on 18.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCProfessorUpload.h"
#import "CCRestKitConfigurator.h"

@implementation CCProfessorUpload

+ (void)configureMappingWithManager:(RKObjectManager *)objectManager
{
    [self configureQuestionsResponse:objectManager];
    [self configureQuestionsRequest:objectManager];
}

+ (void)configureQuestionsResponse:(RKObjectManager *)objectManager
{
    RKObjectMapping *paginationProfessorUploadResponseMapping = [CCRestKitConfigurator paginationMapping];
    
    RKObjectMapping *professorUploadMapping = [RKObjectMapping mappingForClass:[CCProfessorUpload class]];
    [professorUploadMapping  addAttributeMappingsFromDictionary:[CCProfessorUpload responseMappingDictionary]];
    
    RKRelationshipMapping *relationShipResponseQuestionsMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:CCResponseKeys.items
                                                                                                              toKeyPath:CCResponseKeys.items
                                                                                                            withMapping:professorUploadMapping];
    
    [paginationProfessorUploadResponseMapping addPropertyMapping:relationShipResponseQuestionsMapping];
    
    NSString *pathPattern = [NSString stringWithFormat:CCAPIDefines.loadUploads, @":classID"];
    RKResponseDescriptor *responseQuestionsDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:paginationProfessorUploadResponseMapping
                                            pathPattern:pathPattern
                                                keyPath:nil
                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [objectManager addResponseDescriptor:responseQuestionsDescriptor];
}

+ (void)configureQuestionsRequest:(RKObjectManager *)objectManager
{
    RKObjectMapping *questionMapping = [RKObjectMapping mappingForClass:[NSMutableDictionary class]];
    [questionMapping addAttributeMappingsFromDictionary:[CCProfessorUpload requestMappingDictionary]];
    RKRequestDescriptor *questionRequestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:questionMapping objectClass:[CCProfessorUpload class] rootKeyPath:nil];
    [objectManager addRequestDescriptor:questionRequestDescriptor];
}

+ (NSDictionary *)responseMappingDictionary
{
    return @{
             @"id" : @"uploadId",
             @"text" : @"text",
             @"name" : @"name",
             @"owner_id" : @"ownerID",
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
             @"name" : @"name",
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
