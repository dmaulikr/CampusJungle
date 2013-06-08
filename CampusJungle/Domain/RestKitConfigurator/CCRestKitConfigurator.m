//
//  CCRestKitConfigurator.m
//  CollegeConnect
//
//  Created by Vlad Korzun on 15.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCRestKitConfigurator.h"
#import <RestKit/RestKit.h>
#import "CCDefines.h"
#import "CCAlertDefines.h"
#import "CCUser.h"
#import "CCAuthorization.h"
#import "CCAuthorizationResponse.h"
#import "CCPaginationResponse.h"
#import "CCState.h"
#import "CCCity.h"
#import "CCCollege.h"
#import "CCClass.h"
#import "CCEducation.h"

@implementation CCRestKitConfigurator

+ (void)configure
{
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    NSURL *baseURL = [NSURL URLWithString:CCAPIDefines.baseURL];
    AFHTTPClient* client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    
    [client setDefaultHeader:@"Accept" value:RKMIMETypeJSON];
    
    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
    
    [objectManager.HTTPClient setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusNotReachable) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:CCAlertsMessages.noInternetConnection
                                                            message:CCAlertsMessages.connectToTheInternet
                                                           delegate:nil
                                                  cancelButtonTitle:CCAlertsButtons.okButton
                                                  otherButtonTitles:nil];
            [alert show];
        }
    }];
    
    [CCRestKitConfigurator configureUserResponse:objectManager];
    [CCRestKitConfigurator configureClassResponce:objectManager];
    [CCRestKitConfigurator configurePaginationResponse:objectManager];
    [CCRestKitConfigurator configureFacebookLinking:objectManager];

}

+ (void)configureUserResponse:(RKObjectManager *)objectManager
{
    RKObjectMapping *userResponseMapping = [RKObjectMapping mappingForClass:[CCUser class]];
    
    [userResponseMapping addAttributeMappingsFromDictionary:@{
        @"first_name" : @"firstName",
        @"last_name" : @"lastName",
        @"email" : @"email",
        @"avatar" : @"avatar",
        @"token" : @"token",
        @"wallet" : @"wallet",
        @"status" : @"status",
        @"id" : @"uid",
        @"rank" : @"rank",
        @"is_fb_linked" :@"isFacebookLinked"
     }];
    
    
    RKObjectMapping *userEducationResponseMapping = [RKObjectMapping mappingForClass:[CCEducation class]];
    [userEducationResponseMapping addAttributeMappingsFromDictionary:@{
        @"graduation_date" : @"graduationDate",
        @"college_name" : @"collegeName",
        @"user_status" : @"status",
        @"college_id" : @"collegeID",
     }];
    
    RKRelationshipMapping* relationShipResponseEducationsMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:@"educations"
                                                                                                         toKeyPath:@"educations"
                                                                                                       withMapping:userEducationResponseMapping];
    
    [userResponseMapping addPropertyMapping:relationShipResponseEducationsMapping];
    
     RKRelationshipMapping* relationShipResponseUserMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:@"user"
                                                                                                         toKeyPath:@"user"
                                                                                                       withMapping:userResponseMapping];
     RKObjectMapping *authorizationResponseMapping = [RKObjectMapping mappingForClass:[CCAuthorizationResponse class]];
    [authorizationResponseMapping addPropertyMapping:relationShipResponseUserMapping];

    [authorizationResponseMapping addAttributeMappingsFromDictionary:
     @{
        @"is_new_user" : @"isFirstLaunch",
     }];
    
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

+(void)configureClassResponce:(RKObjectManager *)objectManager
{
    RKObjectMapping* classResponseMapping = [RKObjectMapping mappingForClass:[CCClass class]];
    
    [classResponseMapping addAttributeMappingsFromDictionary:@{
     @"professor" : @"professor",
     @"timetable" : @"timetable",
     @"subject" : @"subject",
     @"semester" : @"semester",
     @"call_number":@"callNumber",
     @"id":@"classID",
     }];
        
    RKObjectMapping *classRequestMapping = [RKObjectMapping mappingForClass:[NSMutableDictionary class]];
    [classRequestMapping addAttributeMappingsFromDictionary:@{
     @"professor" : @"professor",
     @"timetable" : @"timetable",
     @"subject" : @"subject",
     @"semester" : @"semester",
     @"call_number":@"callNumber",
     @"id":@"classID",
     }];
    
    
    RKRequestDescriptor *classRequestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:classRequestMapping objectClass:[CCClass class] rootKeyPath:nil];
    
    NSString *classPathPatern = [NSString stringWithFormat:CCAPIDefines.createClass,@":college_id"];
    NSString *classesCollegePathPatern = [NSString stringWithFormat:CCAPIDefines.classesOfCollege,@":college_id"];
    NSString *joinClass = [NSString stringWithFormat:CCAPIDefines.addClass,@":class_id"];

    
    
    RKResponseDescriptor *responseNewClassDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:classResponseMapping
                                                                                     pathPattern:classPathPatern
                                                                                         keyPath:@"class"
                                                                                     statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    
    RKResponseDescriptor *responseAllClassesDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:classResponseMapping
                                                                                                    pathPattern:CCAPIDefines.allClasses
                                                                                                        keyPath:@"classes"
                                                                                                    statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    RKResponseDescriptor *responseClassesOfCollegeDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:classResponseMapping
                                                                                                 pathPattern:classesCollegePathPatern
                                                                                                     keyPath:@"classes"
                                                                                                 statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    RKResponseDescriptor *responseAddClassDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:classResponseMapping
                                                                                                       pathPattern:joinClass
                                                                                                           keyPath:@"classes"
                                                                                                       statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [objectManager addResponseDescriptor:responseAddClassDescriptor];
    [objectManager addResponseDescriptor:responseClassesOfCollegeDescriptor];
    [objectManager addResponseDescriptor:responseNewClassDescriptor];
    [objectManager addResponseDescriptor:responseAllClassesDescriptor];
    [objectManager addRequestDescriptor:classRequestDescriptor];
    
}

+ (void)configurePaginationResponse:(RKObjectManager *)objectManager
{
    RKObjectMapping *paginationStatesResponseMapping  = [CCRestKitConfigurator paginationMapping];
    
    RKObjectMapping *statesMapping = [RKObjectMapping mappingForClass:[CCState class]];
    [statesMapping addAttributeMappingsFromDictionary:@{
        @"id" : @"stateID",
        @"name" : @"name"
     }];
    
    RKObjectMapping *citiesMapping = [RKObjectMapping mappingForClass:[CCCity class]];
    
    [citiesMapping addAttributeMappingsFromDictionary:@{
        @"id" : @"cityID",
        @"name" : @"name"
     }];
    
    RKObjectMapping *collegesMapping = [RKObjectMapping mappingForClass:[CCCollege class]];
    
    [collegesMapping addAttributeMappingsFromDictionary:@{
        @"id" : @"collegeID",
        @"name" : @"name",
        @"address" : @"address"
     }];
    
    
    RKRelationshipMapping* relationShipResponseStatesMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:@"states"
                                                                                                           toKeyPath:CCResponseKeys.items
                                                                                                         withMapping:statesMapping];
    
    
    RKRelationshipMapping* relationShipResponseCitiesMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:@"cities"
                                                                                                         toKeyPath:CCResponseKeys.items
                                                                                                       withMapping:citiesMapping];
    RKRelationshipMapping* relationShipResponseCityMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:@"city"
                                                                                                           toKeyPath:CCResponseKeys.item
                                                                                                         withMapping:citiesMapping];
    RKRelationshipMapping* relationShipResponseCollegesMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:@"colleges"
                                                                                                           toKeyPath:CCResponseKeys.items
                                                                                                           withMapping:collegesMapping];
    RKRelationshipMapping* relationShipResponseCollegeMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:@"college"
                                                                                                             toKeyPath:CCResponseKeys.item
                                                                                                           withMapping:collegesMapping];
    
    
    RKObjectMapping *paginationCitiesResponseMapping = [paginationStatesResponseMapping copy];
    RKObjectMapping *paginationCollegesResponseMapping = [paginationStatesResponseMapping copy];
    
    [paginationCollegesResponseMapping addPropertyMapping:relationShipResponseCollegeMapping];
    [paginationCollegesResponseMapping addPropertyMapping:relationShipResponseCollegesMapping];
    [paginationCitiesResponseMapping addPropertyMapping:relationShipResponseCityMapping];
    [paginationCitiesResponseMapping addPropertyMapping:relationShipResponseCitiesMapping];
    [paginationStatesResponseMapping addPropertyMapping:relationShipResponseStatesMapping];
    
    RKResponseDescriptor *responsePaginationState = [RKResponseDescriptor responseDescriptorWithMapping:paginationStatesResponseMapping pathPattern:CCAPIDefines.states keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    NSString *cityPathPatern = [NSString stringWithFormat:CCAPIDefines.cities,@":stateID"];
    RKResponseDescriptor *responsePaginationCity = [RKResponseDescriptor responseDescriptorWithMapping:paginationCitiesResponseMapping pathPattern:cityPathPatern keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    NSString *collegePathPatern = [NSString stringWithFormat:CCAPIDefines.colleges,@":colleges"];
    RKResponseDescriptor *responsePaginationCollege = [RKResponseDescriptor responseDescriptorWithMapping:paginationCollegesResponseMapping pathPattern:collegePathPatern keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [objectManager addResponseDescriptor:responsePaginationCollege];
    [objectManager addResponseDescriptor:responsePaginationCity];
    [objectManager addResponseDescriptor:responsePaginationState];

}

+ (void)configureFacebookLinking:(RKObjectManager *)objectManager
{
    RKObjectMapping *facebookLingingMapping = [RKObjectMapping mappingForClass:[NSMutableDictionary class]];
    [facebookLingingMapping addAttributeMappingsFromDictionary:@{
                                                                @"success" : @"success"
     }];
    RKResponseDescriptor *responseUserDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:facebookLingingMapping
                                                                                           pathPattern:CCAPIDefines.linkFacebook
                                                                                               keyPath:nil
                                                                                           statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [objectManager addResponseDescriptor:responseUserDescriptor];
}

//+ (void)configure

+ (RKObjectMapping *)paginationMapping
{
    RKObjectMapping *paginationResponseMapping  = [RKObjectMapping mappingForClass:[NSMutableDictionary class]];
    
    [paginationResponseMapping addAttributeMappingsFromDictionary:@{@"count": CCResponseKeys.count}];
    return paginationResponseMapping;
}

@end
