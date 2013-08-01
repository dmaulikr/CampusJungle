//
//  CCMessage.m
//  CampusJungle
//
//  Created by Vlad Korzun on 10.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCMessage.h"
#import "CCRestKitConfigurator.h"

@implementation CCMessage

- (NSString *)modelType
{
    return CCModelsTypes.message;
}

+ (void)configureMappingWithManager:(RKObjectManager *)objectManager
{
    [self configureMessageResponse:objectManager];
}

+ (void)configureMessageResponse:(RKObjectManager *)objectManager
{
    RKObjectMapping *paginationMessageResponseMapping = [CCRestKitConfigurator paginationMapping];
    
    RKObjectMapping *messageMapping = [RKObjectMapping mappingForClass:[CCMessage class]];
    [messageMapping addAttributeMappingsFromDictionary:[CCMessage responseMappingDictionary]];
    
    RKRelationshipMapping* relationShipResponseMessageMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:CCResponseKeys.items
                                                                                                            toKeyPath:CCResponseKeys.items
                                                                                                          withMapping:messageMapping];
    
    [paginationMessageResponseMapping addPropertyMapping:relationShipResponseMessageMapping];
    
    RKResponseDescriptor *responseInboxPaginationMessages = [RKResponseDescriptor responseDescriptorWithMapping:paginationMessageResponseMapping pathPattern:CCAPIDefines.loadMyMessages keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    RKResponseDescriptor *responseOnCreateMessage = [RKResponseDescriptor responseDescriptorWithMapping:messageMapping pathPattern:CCAPIDefines.postMessage keyPath:@"message" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];

    NSString *showMessagePath = [NSString stringWithFormat:CCAPIDefines.getMessage, @":messageId"];
    RKResponseDescriptor *responseOnShowMessage = [RKResponseDescriptor responseDescriptorWithMapping:messageMapping pathPattern:showMessagePath keyPath:@"message" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    
    [objectManager addResponseDescriptor:responseInboxPaginationMessages];
    [objectManager addResponseDescriptor:responseOnCreateMessage];
    [objectManager addResponseDescriptor:responseOnShowMessage];
}

+ (NSDictionary *)responseMappingDictionary
{
    return @{
             @"id" : @"messageID",
             @"receiver_id" : @"receiverID",
             @"receiver_type" : @"receiverType",
             @"sender_id" : @"senderID",
             @"text" : @"text",
             @"created_at" : @"createdAt",
             @"user_first_name" : @"userFirstName",
             @"user_last_name" : @"userLastName",
             @"user_avatar_retina" : @"userAvatar",
             };
}

- (NSString *)description
{
    return self.text;
}

- (void)setCreatedAt:(NSDate *)createdAt
{
    _createdAt = createdAt;
    
}

@end
