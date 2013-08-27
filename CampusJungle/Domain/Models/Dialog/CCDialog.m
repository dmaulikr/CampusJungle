//
//  CCDialog.m
//  CampusJungle
//
//  Created by Vlad Korzun on 16.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCDialog.h"
#import "CCRestKitConfigurator.h"
#import "CCMessage.h"
#import "CCUser.h"

@implementation CCDialog

+ (void)configureMappingWithManager:(RKObjectManager *)objectManager
{
    [self configureDialogResponse:objectManager];
}

+ (void)configureDialogResponse:(RKObjectManager *)objectManager
{
    RKObjectMapping *paginationDialogsResponseMapping = [CCRestKitConfigurator paginationMapping];
    
    RKObjectMapping *messageMapping = [RKObjectMapping mappingForClass:[CCMessage class]];
    [messageMapping addAttributeMappingsFromDictionary:[CCMessage responseMappingDictionary]];
    
    RKObjectMapping *dialogMapper = [RKObjectMapping mappingForClass:[CCDialog class]];
    [dialogMapper addAttributeMappingsFromDictionary:[CCDialog responseMappingDictionary]];
    
    RKRelationshipMapping* relationShipResponseMessageMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:@"last_message"
                                                                                                           toKeyPath:@"lastMessage"
                                                                                                         withMapping:messageMapping];
    
    RKObjectMapping *userMapping = [RKObjectMapping mappingForClass:[CCUser class]];
    [userMapping addAttributeMappingsFromDictionary:[CCUser responseMappingDictionary]];
    
    RKRelationshipMapping *relationshipUserMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:@"interlocutor" toKeyPath:@"interlocutor" withMapping:userMapping];
    
    [dialogMapper addPropertyMapping:relationshipUserMapping];
    [dialogMapper addPropertyMapping:relationShipResponseMessageMapping];

    
    
    RKRelationshipMapping* relationShipResponseDialogMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:CCResponseKeys.items
                                                                                                            toKeyPath:CCResponseKeys.items
                                                                                                          withMapping:dialogMapper];
    
    [paginationDialogsResponseMapping addPropertyMapping:relationShipResponseDialogMapping];
    
    RKResponseDescriptor *responseInboxPaginationDialogs = [RKResponseDescriptor responseDescriptorWithMapping:paginationDialogsResponseMapping pathPattern:CCAPIDefines.myDialogs keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    NSString *pathPattern = [NSString stringWithFormat:CCAPIDefines.dialogForUserWithID,@":userID"];
    RKResponseDescriptor *responseOnRequestDialog = [RKResponseDescriptor responseDescriptorWithMapping:dialogMapper pathPattern:pathPattern keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    NSString *dialogByIdresponcePattern = [NSString stringWithFormat:CCAPIDefines.dialogWithId,@":dialogID"];
    RKResponseDescriptor *responseOnDialogByID = [RKResponseDescriptor responseDescriptorWithMapping:dialogMapper pathPattern:dialogByIdresponcePattern keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [objectManager addResponseDescriptor:responseOnDialogByID];
    [objectManager addResponseDescriptor:responseInboxPaginationDialogs];
    [objectManager addResponseDescriptor:responseOnRequestDialog];
}

+ (NSDictionary *)responseMappingDictionary
{
    return @{
             @"id" : @"dialogID",
             @"speaker1_id" : @"user1",
             @"speaker2_id" : @"user2",
             };
}

@end
