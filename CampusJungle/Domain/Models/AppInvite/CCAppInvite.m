//
//  CCAppInvite.m
//  CampusJungle
//
//  Created by Yury Grinenko on 26.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAppInvite.h"
#import "CCRestKitConfigurator.h"

@implementation CCAppInvite

+ (void)configureMappingWithManager:(RKObjectManager *)objectManager
{
    [self configureResponseMapping:objectManager];
}

+ (void)configureResponseMapping:(RKObjectManager *)objectManager
{
    RKObjectMapping *paginationAppInvitesResponseMapping = [CCRestKitConfigurator paginationMapping];
    
    RKObjectMapping *appInvitesMapping = [RKObjectMapping mappingForClass:[CCAppInvite class]];
    [appInvitesMapping addAttributeMappingsFromDictionary:[CCAppInvite responseMappingDictionary]];
    
    RKRelationshipMapping *relationShipResponseAppInvitesMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:CCResponseKeys.items
                                                                                                            toKeyPath:CCResponseKeys.items
                                                                                                          withMapping:appInvitesMapping];
    
    [paginationAppInvitesResponseMapping addPropertyMapping:relationShipResponseAppInvitesMapping];
    
    NSString *pathPattern = CCAPIDefines.loadAppInvites;
    RKResponseDescriptor *responseAppInvitesDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:paginationAppInvitesResponseMapping
                                            pathPattern:pathPattern
                                                keyPath:nil
                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [objectManager addResponseDescriptor:responseAppInvitesDescriptor];
}

+ (NSDictionary *)responseMappingDictionary
{
    return @{
             @"id" : @"appInviteid",
             @"sender_id" : @"senderId",
             @"recipient_email" : @"recepientEmail",
             @"recipient_facebook_uid" : @"recepientFacebookUid",
             @"recipient_first_name" : @"recepientFirstName",
             @"recipient_last_name" : @"recepientLastName",
             @"recipient_phone_number" : @"recepientPhoneNumber",
             @"recipient_twitter_uid" : @"recepientTwitterUid"
             };
}

@end
