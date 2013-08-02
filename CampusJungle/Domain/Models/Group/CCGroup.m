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

- (NSString *)modelType
{
    return CCModelsTypes.group;
}

+ (CCGroup *)createWithName:(NSString *)name description:(NSString *)description
{
    CCGroup *group = [CCGroup new];
    group.name = name;
    group.description = description;
    return group;
}

+ (void)configureMappingWithManager:(RKObjectManager *)objectManager
{
    [self configureGroupsResponse:objectManager];
    [self configureGroupRequest:objectManager];
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
    NSString *updatePathPattern = [NSString stringWithFormat:CCAPIDefines.updateGroup, @":groupID"];
    RKResponseDescriptor *groupUpdateResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:groupsResponseMapping
                                                                                                  pathPattern:updatePathPattern
                                                                                                      keyPath:@"group"
                                                                                                  statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    NSString *loadGroupPathPattern = [NSString stringWithFormat:CCAPIDefines.loadGroup, @":groupID"];
    RKResponseDescriptor *loadGroupResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:groupsResponseMapping
                                                                                                  pathPattern:loadGroupPathPattern
                                                                                                      keyPath:@"group"
                                                                                                  statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];

    
    [objectManager addResponseDescriptor:classGroupsResponseDescriptor];
    [objectManager addResponseDescriptor:groupUpdateResponseDescriptor];
    [objectManager addResponseDescriptor:loadGroupResponseDescriptor];
}

+ (void)configureGroupRequest:(RKObjectManager *)objectManager
{
    RKObjectMapping *groupMapping = [RKObjectMapping mappingForClass:[NSMutableDictionary class]];
    [groupMapping addAttributeMappingsFromDictionary:[CCGroup requestMappingDictionary]];
    RKRequestDescriptor *groupRequestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:groupMapping objectClass:[CCGroup class] rootKeyPath:nil];
    [objectManager addRequestDescriptor:groupRequestDescriptor];

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
             @"usersIds" : @"users_ids",
             };
}

@end
