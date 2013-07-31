//
//  CCAppInvite.m
//  CampusJungle
//
//  Created by Yury Grinenko on 26.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAppInvite.h"
#import "CCRestKitConfigurator.h"
#import "CCAddressBookRecord.h"

@implementation CCAppInvite

- (NSString *)modelId
{
    return self.appInviteid;
}

+ (CCAppInvite *)createWithAddressBookRecord:(CCAddressBookRecord *)record
{
    CCAppInvite *appInvite = [CCAppInvite new];
    appInvite.recipientFirstName = record.firstName;
    appInvite.recipientLastName = record.lastName;
    if ([record.checkedEmails count] > 0) {
        appInvite.recipientEmail = [record.checkedEmails objectAtIndex:0];
    }
    if ([record.checkedPhoneNumbers count] > 0) {
        appInvite.recipientPhoneNumber = [record.checkedPhoneNumbers objectAtIndex:0];
    }
    return appInvite;
}

+ (void)configureMappingWithManager:(RKObjectManager *)objectManager
{
    [self configureResponseMapping:objectManager];
    [self configureRequestMapping:objectManager];
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

+ (void)configureRequestMapping:(RKObjectManager *)objectManager
{    
    RKObjectMapping *appInviteMapping = [RKObjectMapping mappingForClass:[NSMutableDictionary class]];
    [appInviteMapping addAttributeMappingsFromDictionary:[CCAppInvite requestMappingDictionary]];
    RKRequestDescriptor *appInviteRequestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:appInviteMapping objectClass:[CCAppInvite class] rootKeyPath:@"invites"];

    [objectManager addRequestDescriptor:appInviteRequestDescriptor];
}

+ (NSDictionary *)responseMappingDictionary
{
    return @{
             @"id" : @"appInviteid",
             @"sender_id" : @"senderId",
             @"recipient_email" : @"recipientEmail",
             @"recipient_facebook_uid" : @"recipientFacebookUid",
             @"recipient_first_name" : @"recipientFirstName",
             @"recipient_last_name" : @"recipientLastName",
             @"recipient_phone_number" : @"recipientPhoneNumber",
             @"recipient_twitter_uid" : @"recipientTwitterUid"
             };
}

+ (NSDictionary *)requestMappingDictionary
{
    return @{
             @"recipientEmail" : @"recipient_email",
             @"recipientFacebookUid" : @"recepient_facebook_uid",
             @"recipientFirstName" : @"recepient_first_name",
             @"recipientLastName" : @"recepient_last_name",
             @"recipientPhoneNumber" : @"recepient_phone_number",
             @"recipientTwitterUid" : @"recepient_twitter_uid"
             };
}

@end
