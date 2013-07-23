//
//  CCNote.m
//  CampusJungle
//
//  Created by Vlad Korzun on 08.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCNote.h"
#import "CCNoteUploadInfo.h"
#import "CCRestKitConfigurator.h"

@implementation CCNote

- (NSString *)description
{
    return self.noteDescription;
}

+ (void)configureMappingWithManager:(RKObjectManager *)objectManager
{
    [self configureNotesResponse:objectManager];
    [self configureNotesUploadRequest:objectManager];
    [self configureAttachmentResponse:objectManager];
    [self configureNotesPurchasingResponse:objectManager];
}

+ (void)configureNotesResponse:(RKObjectManager *)objectManager
{
    RKObjectMapping *paginationNotesResponseMapping = [CCRestKitConfigurator paginationMapping];
    RKObjectMapping *notesMapping = [RKObjectMapping mappingForClass:[CCNote class]];
    [notesMapping addAttributeMappingsFromDictionary:[CCNote responseMappingDictionary]];
    
    RKRelationshipMapping* relationShipResponseNotesMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:CCResponseKeys.items
                                                                                                          toKeyPath:CCResponseKeys.items
                                                                                                        withMapping:notesMapping];
    [paginationNotesResponseMapping addPropertyMapping:relationShipResponseNotesMapping];
    RKResponseDescriptor *responsePaginationNote = [RKResponseDescriptor responseDescriptorWithMapping:paginationNotesResponseMapping pathPattern:CCAPIDefines.listOfMyNotes keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    RKResponseDescriptor *responseMarketPaginationNote = [RKResponseDescriptor responseDescriptorWithMapping:paginationNotesResponseMapping pathPattern:CCAPIDefines.notesInMarket keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    NSString *uploadNotesPathPatern = [NSString stringWithFormat:CCAPIDefines.uploadNotesPath,@":CollegeID"];
    RKResponseDescriptor *responseOnCreateNote = [RKResponseDescriptor responseDescriptorWithMapping:notesMapping pathPattern:uploadNotesPathPatern keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    RKResponseDescriptor *responsePurchasedPaginationNote = [RKResponseDescriptor responseDescriptorWithMapping:paginationNotesResponseMapping pathPattern:CCAPIDefines.purchasedNotes keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [objectManager addResponseDescriptor:responsePurchasedPaginationNote];
    [objectManager addResponseDescriptor:responseMarketPaginationNote];
    [objectManager addResponseDescriptor:responseOnCreateNote];
    [objectManager addResponseDescriptor:responsePaginationNote];
}

+ (void)configureNotesUploadRequest:(RKObjectManager *)objectManager
{
    RKObjectMapping *notesMapping = [RKObjectMapping mappingForClass:[NSMutableDictionary class]];
    [notesMapping addAttributeMappingsFromDictionary:[CCNote requestMappingDictionary]];
    RKRequestDescriptor *noteRequestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:notesMapping objectClass:[CCNoteUploadInfo class] rootKeyPath:nil];
    [objectManager addRequestDescriptor:noteRequestDescriptor];
}

+ (void)configureAttachmentResponse:(RKObjectManager *)objectManager
{
    RKObjectMapping *notesLinkMaping = [RKObjectMapping mappingForClass:[NSMutableDictionary class]];
    [notesLinkMaping addAttributeMappingsFromDictionary:[CCNote noteLinkMappingDictionary]];
    
    NSString *pathPattern = [NSString stringWithFormat:CCAPIDefines.notesAttachmentURL,@":noteID"];
    
    RKResponseDescriptor *noteAttacmentDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:notesLinkMaping pathPattern:pathPattern keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [objectManager addResponseDescriptor:noteAttacmentDescriptor];
}

+ (void)configureNotesPurchasingResponse:(RKObjectManager *)objectManager
{
    RKObjectMapping *notesPurchasingResponse = [RKObjectMapping mappingForClass:[NSMutableDictionary class]];
    [notesPurchasingResponse addAttributeMappingsFromDictionary:@{
     @"success" : @"success",
     }];
    
    NSString *pathPattern = [NSString stringWithFormat:CCAPIDefines.purchaseNote,@":noteID"];
    
    RKResponseDescriptor *notesPurchasingResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:notesPurchasingResponse pathPattern:pathPattern keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    NSString *resendLinkPathPattern = [NSString stringWithFormat:CCAPIDefines.resendLinkToNote,@":note"];
    
    RKResponseDescriptor *notesResendingLinkResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:notesPurchasingResponse pathPattern:resendLinkPathPattern keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [objectManager addResponseDescriptor:notesPurchasingResponseDescriptor];
    [objectManager addResponseDescriptor:notesResendingLinkResponseDescriptor];
}

+ (NSDictionary *)responseMappingDictionary
{
    return @{
      @"id" : @"noteID",
      @"name" : @"name",
      @"owner_id" : @"ownerID",
      @"college_id" : @"collegeID",
      @"class_id" : @"classID",
      @"description" : @"noteDescription",
      @"price" : @"price",
      @"full_access_price" : @"fullPrice",
      @"tags" : @"tags",
      @"thumbnail" : @"thumbnail",
      @"thumbnail_retina" : @"thumbnailRetina",
      @"attachment" : @"link",
      @"full_access" : @"fullAccess",
    };
}

+ (NSDictionary *)requestMappingDictionary
{
    return @{
      @"classID" : @"class_id",
      @"name" : @"name",
      @"noteDescription" : @"description",
      @"price" : @"price",
      @"fullPrice" : @"full_access_price",
      @"tags" : @"tags",
      @"pdfUrl" : @"pdf_url",
      @"arrayOfURLs" :@"images_urls",
      @"thumbnail" : @"thumbnail",
    };
}

+ (NSDictionary *)noteLinkMappingDictionary
{
    return @{
      @"note_url" : @"link",
    };
}

@end
