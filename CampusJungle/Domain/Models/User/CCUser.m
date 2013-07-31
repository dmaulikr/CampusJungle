//
//  CCUser.m
//  CollegeConnect
//
//  Created by Vlad Korzun on 21.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCUser.h"
#import "CCAuthorization.h"
#import <FacebookSDK/FacebookSDK.h>
#import "CCDefines.h"

#import "CCEducation.h"
#import "CCAuthorizationResponse.h"
#import "CCRestKitConfigurator.h"

@implementation CCUser

- (NSString *)modelId
{
    return self.uid;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    
    [encoder encodeObject:self.firstName forKey:CCUserDefines.firstName];
    [encoder encodeObject:self.lastName forKey:CCUserDefines.lastName];
    [encoder encodeObject:self.token forKey:CCUserDefines.oauthToken];
    [encoder encodeObject:self.uid forKey:CCUserDefines.uid];
    [encoder encodeObject:self.avatar forKey:CCUserDefines.avatar];
    [encoder encodeObject:self.email forKey:CCUserDefines.email];
    [encoder encodeObject:self.isFacebookLinked forKey:CCUserDefines.isFacebookLinked];
    
    CCAuthorization *facebookOAUTH;
    
    for (CCAuthorization *auth in self.authentications){
        if ([auth.provider isEqualToString:CCUserDefines.facebook]){
            facebookOAUTH = auth;
        }
    }
    [encoder encodeObject:facebookOAUTH.oauthToken forKey:CCUserDefines.facebookToken];
    [encoder encodeObject:facebookOAUTH.uid forKey:CCUserDefines.facebookUID];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        self.firstName = [decoder decodeObjectForKey:CCUserDefines.firstName];
        self.lastName = [decoder decodeObjectForKey:CCUserDefines.lastName];
        self.token = [decoder decodeObjectForKey:CCUserDefines.oauthToken];
        self.uid = [decoder decodeObjectForKey:CCUserDefines.uid];
        self.avatar = [decoder decodeObjectForKey:CCUserDefines.avatar];
        self.email = [decoder decodeObjectForKey:CCUserDefines.email];
        self.isFacebookLinked = [decoder decodeObjectForKey:CCUserDefines.isFacebookLinked];
        CCAuthorization *facebookOAUTH = [CCAuthorization new];
        if([decoder decodeObjectForKey:CCUserDefines.facebookUID]){
            facebookOAUTH.uid = [decoder decodeObjectForKey:CCUserDefines.facebookUID];
            facebookOAUTH.oauthToken = [decoder decodeObjectForKey:CCUserDefines.facebookToken];
            facebookOAUTH.provider = CCUserDefines.facebook;
            self.authentications = @[facebookOAUTH];
        }
    }
    
    return self;
}

+ (void)configureMappingWithManager:(RKObjectManager *)objectManager
{
    [self configureUserResponse:objectManager];
    [self configureClassmatesResponse:objectManager];
}

+ (void)configureUserResponse:(RKObjectManager *)objectManager
{
    RKObjectMapping *userResponseMapping = [RKObjectMapping mappingForClass:[CCUser class]];
    [userResponseMapping addAttributeMappingsFromDictionary:[CCUser responseMappingDictionary]];
    
    RKObjectMapping *userEducationResponseMapping = [RKObjectMapping mappingForClass:[CCEducation class]];
    [userEducationResponseMapping addAttributeMappingsFromDictionary:[CCEducation responseMappingDictionary]];
    
    RKRelationshipMapping* relationShipResponseEducationsMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:@"educations"
                                                                                                               toKeyPath:@"educations"
                                                                                                             withMapping:userEducationResponseMapping];
    
    [userResponseMapping addPropertyMapping:relationShipResponseEducationsMapping];
    
    RKRelationshipMapping* relationShipResponseUserMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:@"user"
                                                                                                         toKeyPath:@"user"
                                                                                                       withMapping:userResponseMapping];
    RKObjectMapping *authorizationResponseMapping = [RKObjectMapping mappingForClass:[CCAuthorizationResponse class]];
    [authorizationResponseMapping addPropertyMapping:relationShipResponseUserMapping];
    
    [authorizationResponseMapping addAttributeMappingsFromDictionary:[CCAuthorizationResponse responseMappingDictionary]];
    
    RKResponseDescriptor *responseAuthorizationDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:authorizationResponseMapping
                                                                                                    pathPattern:CCAPIDefines.authorization
                                                                                                        keyPath:nil
                                                                                                    statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    RKResponseDescriptor *responseSignUpDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:authorizationResponseMapping
                                                                                             pathPattern:CCAPIDefines.signUp
                                                                                                 keyPath:nil
                                                                                             statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    RKResponseDescriptor *responseLoginDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:authorizationResponseMapping
                                                                                            pathPattern:CCAPIDefines.login
                                                                                                keyPath:nil
                                                                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    RKResponseDescriptor *responseUserDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:userResponseMapping
                                                                                           pathPattern:CCAPIDefines.updateUser
                                                                                               keyPath:@"user"
                                                                                           statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [objectManager addResponseDescriptor:responseUserDescriptor];
    [objectManager addResponseDescriptor:responseAuthorizationDescriptor];
    [objectManager addResponseDescriptor:responseSignUpDescriptor];
    [objectManager addResponseDescriptor:responseLoginDescriptor];
    
    
    RKObjectMapping *userRequestMapping = [RKObjectMapping mappingForClass:[NSMutableDictionary class]];
    [userRequestMapping addAttributeMappingsFromDictionary:@{
     @"firstName" : @"user[first_name]",
     @"lastName" : @"user[last_name]",
     @"email" :@"user[email]",
     @"avatar" : @"user[avatar]",
     }];
    RKObjectMapping *educationRequestMapping = [RKObjectMapping mappingForClass:[NSMutableDictionary class]];
    [educationRequestMapping addAttributeMappingsFromDictionary:@{
     @"graduationDate" : @"graduation_date",
     @"collegeID" : @"college_id",
     @"status" : @"user_status",
     }];
    
    RKRelationshipMapping* relationShipRequestEducationMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:@"educations"
                                                                                                             toKeyPath:@"educations"
                                                                                                           withMapping:educationRequestMapping];
    [userRequestMapping addPropertyMapping:relationShipRequestEducationMapping];
    
    RKRequestDescriptor *userRequestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:userRequestMapping objectClass:[CCUser class] rootKeyPath:nil];
    [objectManager addRequestDescriptor:userRequestDescriptor];
}

+ (void)configureClassmatesResponse:(RKObjectManager *)objectManager
{
    RKObjectMapping *userResponseMapping = [RKObjectMapping mappingForClass:[CCUser class]];
    [userResponseMapping addAttributeMappingsFromDictionary:[CCUser responseMappingDictionary]];
    
    RKObjectMapping *userEducationResponseMapping = [RKObjectMapping mappingForClass:[CCEducation class]];
    [userEducationResponseMapping addAttributeMappingsFromDictionary:[CCEducation responseMappingDictionary]];
    
    RKRelationshipMapping* relationShipResponseEducationsMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:@"educations"
                                                                                                               toKeyPath:@"educations"
                                                                                                             withMapping:userEducationResponseMapping];
    [userResponseMapping addPropertyMapping:relationShipResponseEducationsMapping];
    
    RKObjectMapping *paginationClassmatesResponseMapping = [CCRestKitConfigurator paginationMapping];
    RKRelationshipMapping *relationshipResponseClassmatesMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:CCResponseKeys.items
                                                                                                             toKeyPath:CCResponseKeys.items
                                                                                                           withMapping:userResponseMapping];
    [paginationClassmatesResponseMapping addPropertyMapping:relationshipResponseClassmatesMapping];
    
    NSString *pathPattern = [NSString stringWithFormat:CCAPIDefines.classmates,@":classID"];
    RKResponseDescriptor *classmatesResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:paginationClassmatesResponseMapping
                                                                                                       pathPattern:pathPattern
                                                                                                           keyPath:nil
                                                                                                       statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    NSString *userResponceMappingPath = [NSString stringWithFormat:CCAPIDefines.getUser,@":UserID"];
    RKResponseDescriptor *userResponceDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:userResponseMapping pathPattern:userResponceMappingPath keyPath:@"user" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    NSString *groupmatesResponceMappingPath = [NSString stringWithFormat:CCAPIDefines.loadGroupMembers,@":groupID"];
    RKResponseDescriptor *groupmatesResponceDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:paginationClassmatesResponseMapping pathPattern:groupmatesResponceMappingPath keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    

    NSString *classmatesToInviteInGroupResponceMappingPath = [NSString stringWithFormat:CCAPIDefines.loadClassmatesToInviteInGroup,@":groupID"];
    RKResponseDescriptor *classmatesToInviteInGroupResponceDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:paginationClassmatesResponseMapping pathPattern:classmatesToInviteInGroupResponceMappingPath keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [objectManager addResponseDescriptor:classmatesResponseDescriptor];
    [objectManager addResponseDescriptor:userResponceDescriptor];
    [objectManager addResponseDescriptor:groupmatesResponceDescriptor];
    [objectManager addResponseDescriptor:classmatesToInviteInGroupResponceDescriptor];
}

+ (NSDictionary *)responseMappingDictionary
{
    return @{
      @"first_name" : @"firstName",
      @"last_name" : @"lastName",
      @"email" : @"email",
      @"avatar_retina" : @"avatar",
      @"token" : @"token",
      @"wallet" : @"wallet",
      @"status" : @"status",
      @"id" : @"uid",
      @"rank" : @"rank",
      @"is_fb_linked" :@"isFacebookLinked"
      };
}

@end
