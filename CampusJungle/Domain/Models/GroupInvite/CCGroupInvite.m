//
//  CCGroupInvite.m
//  CampusJungle
//
//  Created by Yury Grinenko on 24.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCGroupInvite.h"
#import "CCRestKitConfigurator.h"

@implementation CCGroupInvite

+ (void)configureMappingWithManager:(RKObjectManager *)objectManager
{
    [self configureResponseMapping:objectManager];
}

+ (void)configureResponseMapping:(RKObjectManager *)objectManager
{
    RKObjectMapping *paginationGroupInvitesResponseMapping = [CCRestKitConfigurator paginationMapping];
    RKObjectMapping *groupInvitesResponseMapping = [RKObjectMapping mappingForClass:[CCGroupInvite class]];
    [groupInvitesResponseMapping addAttributeMappingsFromDictionary:[CCGroupInvite responseMappingDictionary]];
    RKRelationshipMapping *relationshipResponseGroupInvitesMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:CCResponseKeys.items
                                                                                                           toKeyPath:CCResponseKeys.items
                                                                                                         withMapping:groupInvitesResponseMapping];
    [paginationGroupInvitesResponseMapping addPropertyMapping:relationshipResponseGroupInvitesMapping];
    
    NSString *pathPattern = CCAPIDefines.loadGroupInvites;
    RKResponseDescriptor *groupInvitesResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:paginationGroupInvitesResponseMapping
                                                                                                  pathPattern:pathPattern
                                                                                                      keyPath:nil
                                                                                                  statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [objectManager addResponseDescriptor:groupInvitesResponseDescriptor];
}

+ (NSDictionary *)responseMappingDictionary
{
    return @{
         @"id" : @"groupInviteId",
         @"text" : @"text",
         @"updated_at" : @"updatedDate",
         @"group_name" : @"groupName",
         @"group_description" : @"groupDescription",
         @"user_first_name" : @"userFirstName",
         @"user_last_name" : @"userLastName",
         @"user_avatar_retina" : @"userAvatar",
         @"sender_id" : @"senderId",
         @"recipient_id" : @"recepientId",
         @"college_name" : @"collegeName",
         @"class_name" : @"className",
    };
}

@end
