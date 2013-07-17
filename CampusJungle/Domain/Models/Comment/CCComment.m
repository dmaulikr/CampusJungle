//
//  CCComment.m
//  CampusJungle
//
//  Created by Yury Grinenko on 17.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCComment.h"
#import "CCRestKitConfigurator.h"

@implementation CCComment

+ (void)configureMappingWithManager:(RKObjectManager *)objectManager
{
    [self configureRequestMapping:objectManager];
    [self configureResponseMapping:objectManager];
}

+ (void)configureResponseMapping:(RKObjectManager *)objectManager
{
    RKObjectMapping *paginationCommentsResponseMapping = [CCRestKitConfigurator paginationMapping];
    
    RKObjectMapping *commentsMapping = [RKObjectMapping mappingForClass:[CCComment class]];
    [commentsMapping addAttributeMappingsFromDictionary:[CCComment responseMappingDictionary]];
    
    RKRelationshipMapping *relationShipResponseCommentsMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:CCResponseKeys.items
                                                                                                            toKeyPath:CCResponseKeys.items
                                                                                                          withMapping:commentsMapping];
    
    [paginationCommentsResponseMapping addPropertyMapping:relationShipResponseCommentsMapping];
    
    NSString *pathPattern = [NSString stringWithFormat:CCAPIDefines.loadComments, @":answerID"];
    RKResponseDescriptor *responseCommentsDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:paginationCommentsResponseMapping
                                            pathPattern:pathPattern
                                                keyPath:nil
                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [objectManager addResponseDescriptor:responseCommentsDescriptor];
}

+ (void)configureRequestMapping:(RKObjectManager *)objectManager
{
    RKObjectMapping *commentMapping = [RKObjectMapping mappingForClass:[NSMutableDictionary class]];
    [commentMapping addAttributeMappingsFromDictionary:[CCComment requestMappingDictionary]];
    RKRequestDescriptor *commentRequestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:commentMapping objectClass:[CCComment class] rootKeyPath:nil];
    [objectManager addRequestDescriptor:commentRequestDescriptor];
}

+ (NSDictionary *)responseMappingDictionary
{
    return @{
             @"id" : @"commentId",
             @"answer_id" : @"answerId",
             @"text" : @"text",
             @"owner_id" : @"ownerId",
             @"owner_first_name" : @"ownerFirstName",
             @"owner_last_name" : @"ownerLastName",
             @"created_at" : @"createdDate",
             };
}

+ (NSDictionary *)requestMappingDictionary
{
    return @{
             @"text" : @"text"
             };
}

@end
