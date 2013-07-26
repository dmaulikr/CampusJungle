//
//  CCStuff.m
//  CampusJungle
//
//  Created by Vlad Korzun on 20.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCStuff.h"

#import "CCRestKitConfigurator.h"
#import "CCStuffUploadInfo.h"
#import "CCPhoto.h"

@implementation CCStuff

- (NSString *)description
{
    return self.name;
}

+ (void)configureMappingWithManager:(RKObjectManager *)objectManager
{
    [self configureStuffCreationRequest:objectManager];
    [self configureStuffResponse:objectManager];
}

+ (void)configureStuffCreationRequest:(RKObjectManager *)objectManager
{
    RKObjectMapping *stuffMapping = [RKObjectMapping mappingForClass:[NSMutableDictionary class]];
    [stuffMapping addAttributeMappingsFromDictionary:[CCStuff requestMappingDictionary]];
    RKRequestDescriptor *stuffRequestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:stuffMapping objectClass:[CCStuffUploadInfo class] rootKeyPath:nil];
    [objectManager addRequestDescriptor:stuffRequestDescriptor];
}

+ (void)configureStuffResponse:(RKObjectManager *)objectManager
{
    RKObjectMapping *paginationNotesResponseMapping = [CCRestKitConfigurator paginationMapping];
    RKObjectMapping *stuffMapping = [RKObjectMapping mappingForClass:[CCStuff class]];
    [stuffMapping addAttributeMappingsFromDictionary:[CCStuff responseMappingDictionary]];
    
    RKRelationshipMapping* relationShipResponseStuffMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:CCResponseKeys.items
                                                                                                          toKeyPath:CCResponseKeys.items
                                                                                                        withMapping:stuffMapping];
    [paginationNotesResponseMapping addPropertyMapping:relationShipResponseStuffMapping];
    
    RKObjectMapping *photosMapping = [RKObjectMapping mappingForClass:[CCPhoto class]];
    [photosMapping addAttributeMappingsFromDictionary:[CCPhoto responseMappingDictionary]];
    
    RKRelationshipMapping* relationShipPhotosMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:@"photos"
                                                                                                   toKeyPath:@"photos"
                                                                                                 withMapping:photosMapping];
    [stuffMapping addPropertyMapping:relationShipPhotosMapping];
    
    RKResponseDescriptor *responsePaginationStuff = [RKResponseDescriptor responseDescriptorWithMapping:paginationNotesResponseMapping pathPattern:CCAPIDefines.loadMyStuff keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    RKResponseDescriptor *responseMarketPaginationStuff = [RKResponseDescriptor responseDescriptorWithMapping:paginationNotesResponseMapping pathPattern:CCAPIDefines.stuffInMarket keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    NSString *uploadStuffPathPatern = [NSString stringWithFormat:CCAPIDefines.createStuff,@":CollegeID"];
    RKResponseDescriptor *responseOnCreateStuff = [RKResponseDescriptor responseDescriptorWithMapping:stuffMapping pathPattern:uploadStuffPathPatern keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    NSString *getSingleStuffPathPattern = [NSString stringWithFormat:CCAPIDefines.getStuff,@":StuffID"];
    RKResponseDescriptor *responseOnGetStuffRequest = [RKResponseDescriptor responseDescriptorWithMapping:stuffMapping pathPattern:getSingleStuffPathPattern keyPath:@"stuff" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [objectManager addResponseDescriptor:responseOnGetStuffRequest];
    [objectManager addResponseDescriptor:responseMarketPaginationStuff];
    [objectManager addResponseDescriptor:responseOnCreateStuff];
    [objectManager addResponseDescriptor:responsePaginationStuff];
    
}

+ (NSDictionary *)responseMappingDictionary
{
    return @{
      @"id" : @"stuffID",
      @"name" : @"name",
      @"owner_id" : @"ownerID",
      @"college_id" : @"collegeID",
      @"class_id" : @"classID",
      @"description" : @"stuffDescription",
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
      @"stuffDescription" : @"description",
      @"price" : @"price",
      @"arrayOfURLs" :@"images",
    };
}

@end
