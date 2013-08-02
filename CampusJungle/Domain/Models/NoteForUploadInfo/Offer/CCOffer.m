//
//  CCOffer.m
//  CampusJungle
//
//  Created by Vlad Korzun on 08.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCOffer.h"
#import "CCRestKitConfigurator.h"

@implementation CCOffer

- (NSString *)modelType
{
    return CCModelsTypes.offer;
}

- (NSString *)modelID
{
    return self.offerID;
}

+ (void)configureMappingWithManager:(RKObjectManager *)objectManager
{
    [self configureOfferResponse:objectManager];
}

+ (void)configureOfferResponse:(RKObjectManager *)objectManager
{
    RKObjectMapping *paginationOffersResponseMapping = [CCRestKitConfigurator paginationMapping];
    
    RKObjectMapping *offerMapping = [RKObjectMapping mappingForClass:[CCOffer class]];
    [offerMapping addAttributeMappingsFromDictionary:[CCOffer responseMappingDictionary]];
    
    RKRelationshipMapping* relationShipResponseOfferMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:CCResponseKeys.items
                                                                                                          toKeyPath:CCResponseKeys.items
                                                                                                        withMapping:offerMapping];
    
    [paginationOffersResponseMapping addPropertyMapping:relationShipResponseOfferMapping];
    
    RKResponseDescriptor *responseInboxPaginationOffers = [RKResponseDescriptor responseDescriptorWithMapping:paginationOffersResponseMapping pathPattern:CCAPIDefines.recivedOffers keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    NSString *uploadOfferPathPatern = [NSString stringWithFormat:CCAPIDefines.makeOffer ,@":StuffID"];
    RKResponseDescriptor *responseOnCreateOffer = [RKResponseDescriptor responseDescriptorWithMapping:offerMapping pathPattern:uploadOfferPathPatern keyPath:@"offer" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [objectManager addResponseDescriptor:responseInboxPaginationOffers];
    [objectManager addResponseDescriptor:responseOnCreateOffer];
}

+ (NSDictionary *)responseMappingDictionary
{
    return @{
             @"id" : @"offerID",
             @"stuff_id" : @"stuffID",
             @"text" : @"text",
             @"sender_id" : @"senderID",
             @"receiver_id" : @"receiverID",
             @"user_first_name" : @"userFirstName",
             @"user_last_name" : @"userLastName",
             @"user_avatar_retina" : @"userAvatar",
             @"created_at" : @"createdAt",
             };
}

- (NSString *)description
{
    return self.text;
}

@end
