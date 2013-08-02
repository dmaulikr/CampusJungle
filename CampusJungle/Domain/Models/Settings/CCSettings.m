//
//  CCSettings.m
//  CampusJungle
//
//  Created by Vlad Korzun on 02.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCSettings.h"

@implementation CCSettings


+ (void)configureMappingWithManager:(RKObjectManager *)objectManager
{
    [self configureSettingResponse:objectManager];
    [self configureSettingRequest:objectManager];
}

+ (void)configureSettingResponse:(RKObjectManager *)objectManager
{
    RKObjectMapping *settingMapping = [RKObjectMapping mappingForClass:[CCSettings class]];
    [settingMapping addAttributeMappingsFromDictionary:[CCSettings responseMappingDictionary]];
    
    RKResponseDescriptor *responseInboxPaginationMessages =
    [RKResponseDescriptor responseDescriptorWithMapping:settingMapping
                                            pathPattern:CCAPIDefines.getSettings
                                                keyPath:@"settings"
                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [objectManager addResponseDescriptor:responseInboxPaginationMessages];
}

+ (void)configureSettingRequest:(RKObjectManager *)objectManager
{
    RKObjectMapping *settingMapping = [RKObjectMapping mappingForClass:[NSMutableDictionary class]];
    [settingMapping addAttributeMappingsFromDictionary:[CCSettings requestMappingDictionary]];
    
    RKRequestDescriptor *requestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:settingMapping objectClass:[CCSettings class] rootKeyPath:nil];
    [objectManager addRequestDescriptor:requestDescriptor];
}



+ (NSDictionary *)requestMappingDictionary
{
    return @{
             @"classesNotifications" : @"classes_notifications_allowed",
             @"forumsNotifications" : @"forums_notifications_allowed",
             @"messagesNotificaitons" : @"messages_notificaitons_allowed"
             };
}

+ (NSDictionary *)responseMappingDictionary
{
    return @{
             @"classes_notifications_allowed" : @"classesNotifications",
             @"forums_notifications_allowed" : @"forumsNotifications",
             @"messages_notificaitons_allowed" : @"messagesNotificaitons"
             };
}

@end
