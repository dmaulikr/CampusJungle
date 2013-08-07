//
//  CCBook.m
//  CampusJungle
//
//  Created by Vlad Korzun on 06.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCBook.h"
#import "CCBookUploadInfo.h"
#import "CCRestKitConfigurator.h"
#import "CCPhoto.h"

@implementation CCBook

- (NSString *)modelType
{
    return CCModelsTypes.book;
}

- (NSString *)modelID
{
    return self.bookID;
}

+ (void)configureMappingWithManager:(RKObjectManager *)objectManager
{
    [self configurebookCreationRequest:objectManager];
    [self configurebookResponse:objectManager];
}

+ (void)configurebookCreationRequest:(RKObjectManager *)objectManager
{
    RKObjectMapping *bookMapping = [RKObjectMapping mappingForClass:[NSMutableDictionary class]];
    [bookMapping addAttributeMappingsFromDictionary:[CCBook requestMappingDictionary]];
    RKRequestDescriptor *bookRequestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:bookMapping objectClass:[CCBookUploadInfo class] rootKeyPath:nil];
    [objectManager addRequestDescriptor:bookRequestDescriptor];
}

+ (void)configurebookResponse:(RKObjectManager *)objectManager
{
    RKObjectMapping *paginationNotesResponseMapping = [CCRestKitConfigurator paginationMapping];
    RKObjectMapping *bookMapping = [RKObjectMapping mappingForClass:[CCBook class]];
    [bookMapping addAttributeMappingsFromDictionary:[CCBook responseMappingDictionary]];
    
    RKRelationshipMapping* relationShipResponsebookMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:CCResponseKeys.items
                                                                                                          toKeyPath:CCResponseKeys.items
                                                                                                        withMapping:bookMapping];
    [paginationNotesResponseMapping addPropertyMapping:relationShipResponsebookMapping];
    
    RKObjectMapping *photosMapping = [RKObjectMapping mappingForClass:[CCPhoto class]];
    [photosMapping addAttributeMappingsFromDictionary:[CCPhoto responseMappingDictionary]];
    
    RKRelationshipMapping* relationShipPhotosMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:@"photos"
                                                                                                   toKeyPath:@"photos"
                                                                                                 withMapping:photosMapping];
    [bookMapping addPropertyMapping:relationShipPhotosMapping];
    
    RKResponseDescriptor *responsePaginationbook = [RKResponseDescriptor responseDescriptorWithMapping:paginationNotesResponseMapping pathPattern:CCAPIDefines.loadMyBooks keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    RKResponseDescriptor *responseMarketPaginationbook = [RKResponseDescriptor responseDescriptorWithMapping:paginationNotesResponseMapping pathPattern:CCAPIDefines.bookInMarket keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    NSString *uploadbookPathPatern = [NSString stringWithFormat:CCAPIDefines.createBook,@":CollegeID"];
    RKResponseDescriptor *responseOnCreatebook = [RKResponseDescriptor responseDescriptorWithMapping:bookMapping pathPattern:uploadbookPathPatern keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    NSString *getSinglebookPathPattern = [NSString stringWithFormat:CCAPIDefines.getBook,@":bookID"];
    RKResponseDescriptor *responseOnGetbookRequest = [RKResponseDescriptor responseDescriptorWithMapping:bookMapping pathPattern:getSinglebookPathPattern keyPath:@"book" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [objectManager addResponseDescriptor:responseOnGetbookRequest];
    [objectManager addResponseDescriptor:responseMarketPaginationbook];
    [objectManager addResponseDescriptor:responseOnCreatebook];
    [objectManager addResponseDescriptor:responsePaginationbook];
    
}

+ (NSDictionary *)responseMappingDictionary
{
    return @{
             @"id" : @"bookID",
             @"name" : @"name",
             @"owner_id" : @"ownerID",
             @"college_id" : @"collegeID",
             @"isbn" : @"isbn",
             @"class_id" : @"classID",
             @"description" : @"description",
             @"price" : @"price",
             @"tags" : @"tags",
             @"thumbnail" : @"thumbnail",
             @"thumbnail_retina" : @"thumbnailRetina",
             };
}

+ (NSDictionary *)requestMappingDictionary
{
    return @{
             @"collegeID" : @"class_id",
             @"name" : @"name",
             @"isbn" : @"isbn",
             @"description" : @"description",
             @"price" : @"price",
             @"arrayOfURLs" :@"images",
             };
}

@end
