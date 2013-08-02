//
//  CCAnouncement.m
//  CampusJungle
//
//  Created by Vlad Korzun on 22.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAnnouncement.h"
#import "CCRestKitConfigurator.h"

@implementation CCAnnouncement

- (NSString *)modelType
{
    return CCModelsTypes.announcement;
}

- (NSString *)modelID
{
    return self.announcementID;
}

+ (void)configureMappingWithManager:(RKObjectManager *)objectManager
{
    [self configureRequestMapping:objectManager];
    [self configureResponseMapping:objectManager];
}

+ (void)configureResponseMapping:(RKObjectManager *)objectManager
{
    RKObjectMapping *paginationAnnouncementsResponseMapping = [CCRestKitConfigurator paginationMapping];
    
    RKObjectMapping *announcementsMapping = [RKObjectMapping mappingForClass:[CCAnnouncement class]];
    [announcementsMapping addAttributeMappingsFromDictionary:[CCAnnouncement responseMappingDictionary]];
    
    RKRelationshipMapping *relationShipResponseAnnouncementsMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:CCResponseKeys.items
                                                                                                            toKeyPath:CCResponseKeys.items
                                                                                                          withMapping:announcementsMapping];
    
    [paginationAnnouncementsResponseMapping addPropertyMapping:relationShipResponseAnnouncementsMapping];
    
    NSString *pathPattern = [NSString stringWithFormat:CCAPIDefines.loadAnnouncements, @":announcementID"];
    RKResponseDescriptor *responseAnnouncementsDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:paginationAnnouncementsResponseMapping
                                            pathPattern:pathPattern
                                                keyPath:nil
                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    NSString *creationPathPattern = [NSString stringWithFormat:CCAPIDefines.postAnnouncements,@":classID"];
    RKResponseDescriptor *responsePostAnnouncementDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:announcementsMapping
                                            pathPattern:creationPathPattern
                                                keyPath:nil
                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];

    
    [objectManager addResponseDescriptor:responsePostAnnouncementDescriptor];
    [objectManager addResponseDescriptor:responseAnnouncementsDescriptor];
}

+ (void)configureRequestMapping:(RKObjectManager *)objectManager
{
    RKObjectMapping *announcementMapping = [RKObjectMapping mappingForClass:[NSMutableDictionary class]];
    [announcementMapping addAttributeMappingsFromDictionary:[CCAnnouncement requestMappingDictionary]];
    RKRequestDescriptor *announcementRequestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:announcementMapping objectClass:[CCAnnouncement class] rootKeyPath:nil];
    [objectManager addRequestDescriptor:announcementRequestDescriptor];
}

+ (NSDictionary *)responseMappingDictionary
{
    return @{
             @"id" : @"announcementID",
             @"text" : @"message",
             @"description" : @"topic",
             @"sender_id" : @"ownerId",
             @"owner_first_name" : @"ownerFirstName",
             @"owner_last_name" : @"ownerLastName",
             @"comments_count" : @"commentsCount",
             @"created_at" : @"createdDate",
             };
}

+ (NSDictionary *)requestMappingDictionary
{
    return @{
             @"message" : @"text",
             @"topic" : @"description",
             };
}


@end
