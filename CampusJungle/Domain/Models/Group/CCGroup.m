//
//  CCGroup.m
//  CampusJungle
//
//  Created by Yury Grinenko on 11.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCGroup.h"
#import "CCRestKitConfigurator.h"

@implementation CCGroup

+ (void)configureMappingWithManager:(RKObjectManager *)objectManager
{
    [self configureGroupsResponse:objectManager];
}

+ (void)configureGroupsResponse:(RKObjectManager *)objectManager
{
    RKObjectMapping *paginationGroupsResponseMapping = [CCRestKitConfigurator paginationMapping];
    RKObjectMapping *groupsResponseMapping = [RKObjectMapping mappingForClass:[CCGroup class]];
    [groupsResponseMapping addAttributeMappingsFromDictionary:[CCGroup responseMappingDictionary]];
    RKRelationshipMapping *relationshipResponseGroupsMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:CCResponseKeys.items
                                                                                                           toKeyPath:CCResponseKeys.items
                                                                                                         withMapping:groupsResponseMapping];
    
    
    [paginationGroupsResponseMapping addPropertyMapping:relationshipResponseGroupsMapping];
    
    NSString *pathPattern = [NSString stringWithFormat:CCAPIDefines.loadGroups, @":classID"];
    
    RKResponseDescriptor *classGroupsResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:paginationGroupsResponseMapping
                                                                                                  pathPattern:pathPattern
                                                                                                      keyPath:nil
                                                                                                  statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [objectManager addResponseDescriptor:classGroupsResponseDescriptor];
}

+ (NSDictionary *)responseMappingDictionary
{
    return @{
             @"id" : @"groupId",
             @"description" : @"description",
             @"name" : @"name",
             @"owner_id" : @"ownerId",
             @"klass_id" : @"classId",
             @"image_retina" : @"image",
             @"owner_first_name" : @"ownerFirstName",
             @"owner_last_name" : @"ownerLastName",
             @"members_count" : @"membersCount"
             };
}

+ (NSDictionary *)requestMappingDictionary
{
    return @{
             @"description" : @"description",
             @"name" : @"name",
             @"classId" : @"class_id",
             @"image" : @"image",
             };
}

@end
