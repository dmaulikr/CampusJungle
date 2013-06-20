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
#import "CCNote.h"
#import "CCNoteUploadInfo.h"

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
    [CCRestKitConfigurator configureCollegeResponse:objectManager];
    [CCRestKitConfigurator configureCityResponse:objectManager];
    [CCRestKitConfigurator configureStateResponse:objectManager];
    [CCRestKitConfigurator configureFacebookLinking:objectManager];
    [CCRestKitConfigurator configureNotesResponse:objectManager];
    [CCRestKitConfigurator configureNotesUploadRequest:objectManager];
    [CCRestKitConfigurator configureAttachmentResponse:objectManager];
    [CCRestKitConfigurator configureNotesPurchasingResponse:objectManager];

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
     @"college_name" : @"collegeName",
     @"college_id" : @"collegeID",
     }];
        
    RKObjectMapping *classRequestMapping = [RKObjectMapping mappingForClass:[NSMutableDictionary class]];
    [classRequestMapping addAttributeMappingsFromDictionary:@{
     @"professor" : @"professor",
     @"timetable" : @"timetable",
     @"subject" : @"subject",
     @"semester" : @"semester",
     @"call_number":@"callNumber",
     @"id":@"classID",
     @"college_name" : @"collegeName",
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
                                                                                                     keyPath:@"items"
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

+ (void)configureCollegeResponse:(RKObjectManager *)objectManager
{
       
    RKObjectMapping *collegesMapping = [RKObjectMapping mappingForClass:[CCCollege class]];
    
    [collegesMapping addAttributeMappingsFromDictionary:@{
        @"id" : @"collegeID",
        @"name" : @"name",
        @"address" : @"address"
     }];
    
    
    RKRelationshipMapping* relationShipResponseCollegesMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:CCResponseKeys.items
                                                                                                           toKeyPath:CCResponseKeys.items
                                                                                                           withMapping:collegesMapping];
    RKRelationshipMapping* relationShipResponseCollegeMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:@"college"
                                                                                                             toKeyPath:CCResponseKeys.item
                                                                                                           withMapping:collegesMapping];
    
    RKObjectMapping *paginationCollegesResponseMapping = [CCRestKitConfigurator paginationMapping];
    
    [paginationCollegesResponseMapping addPropertyMapping:relationShipResponseCollegeMapping];
    [paginationCollegesResponseMapping addPropertyMapping:relationShipResponseCollegesMapping];

    NSString *collegePathPatern = [NSString stringWithFormat:CCAPIDefines.colleges,@":colleges"];
    RKResponseDescriptor *responsePaginationCollege = [RKResponseDescriptor responseDescriptorWithMapping:paginationCollegesResponseMapping pathPattern:collegePathPatern keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [objectManager addResponseDescriptor:responsePaginationCollege];
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

+ (void)configureStateResponse:(RKObjectManager *)objectManager
{
    RKObjectMapping *paginationStatesResponseMapping  = [CCRestKitConfigurator paginationMapping];
    
    RKObjectMapping *statesMapping = [RKObjectMapping mappingForClass:[CCState class]];
    [statesMapping addAttributeMappingsFromDictionary:@{
     @"id" : @"stateID",
     @"name" : @"name"
     }];
    RKRelationshipMapping* relationShipResponseStatesMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:CCResponseKeys.items
                                                                                                           toKeyPath:CCResponseKeys.items
                                                                                                         withMapping:statesMapping];

     RKResponseDescriptor *responsePaginationState = [RKResponseDescriptor responseDescriptorWithMapping:paginationStatesResponseMapping pathPattern:CCAPIDefines.states keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [paginationStatesResponseMapping addPropertyMapping:relationShipResponseStatesMapping];
    [objectManager addResponseDescriptor:responsePaginationState];
}

+ (void)configureCityResponse:(RKObjectManager *)objectManager
{
    RKObjectMapping *paginationCitiesResponseMapping = [CCRestKitConfigurator paginationMapping];
    RKObjectMapping *citiesMapping = [RKObjectMapping mappingForClass:[CCCity class]];
    
    [citiesMapping addAttributeMappingsFromDictionary:@{
     @"id" : @"cityID",
     @"name" : @"name"
     }];
    RKRelationshipMapping* relationShipResponseCitiesMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:CCResponseKeys.items
                                                                                                           toKeyPath:CCResponseKeys.items
                                                                                                         withMapping:citiesMapping];
    RKRelationshipMapping* relationShipResponseCityMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:@"city"
                                                                                                         toKeyPath:CCResponseKeys.item
                                                                                                       withMapping:citiesMapping];
    [paginationCitiesResponseMapping addPropertyMapping:relationShipResponseCityMapping];
    [paginationCitiesResponseMapping addPropertyMapping:relationShipResponseCitiesMapping];
    NSString *cityPathPatern = [NSString stringWithFormat:CCAPIDefines.cities,@":stateID"];
    RKResponseDescriptor *responsePaginationCity = [RKResponseDescriptor responseDescriptorWithMapping:paginationCitiesResponseMapping pathPattern:cityPathPatern keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [objectManager addResponseDescriptor:responsePaginationCity];
}

+ (void)configureNotesResponse:(RKObjectManager *)objectManager
{
    RKObjectMapping *paginationNotesResponseMapping = [CCRestKitConfigurator paginationMapping];
    RKObjectMapping *notesMapping = [RKObjectMapping mappingForClass:[CCNote class]];
    [notesMapping addAttributeMappingsFromDictionary:@{
     @"id" : @"noteID",
     @"owner_id" : @"ownerID",
     @"college_id" : @"collegeID",
     @"class_id" : @"classID",
     @"description" : @"noteDescription",
     @"price" : @"price",
     @"full_access_price" : @"fullPrice",
     @"tags" : @"tags",
     @"thumbnail" : @"thumbnail",
     @"thumbnail_retina" : @"thumbnailRetina",
     @"attachment" : @"link",
     @"full_access" : @"fullAccess",
     }];
    
    RKRelationshipMapping* relationShipResponseCitiesMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:CCResponseKeys.items
                                                                                                           toKeyPath:CCResponseKeys.items
                                                                                                         withMapping:notesMapping];
    [paginationNotesResponseMapping addPropertyMapping:relationShipResponseCitiesMapping];
    RKResponseDescriptor *responsePaginationNote = [RKResponseDescriptor responseDescriptorWithMapping:paginationNotesResponseMapping pathPattern:CCAPIDefines.listOfMyNotes keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    RKResponseDescriptor *responseMarketPaginationNote = [RKResponseDescriptor responseDescriptorWithMapping:paginationNotesResponseMapping pathPattern:CCAPIDefines.notesInMarket keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    NSString *uploadNotesPathPatern = [NSString stringWithFormat:CCAPIDefines.uploadNotesPath,@":CollegeID"];
     RKResponseDescriptor *responseOnCreateNote = [RKResponseDescriptor responseDescriptorWithMapping:notesMapping pathPattern:uploadNotesPathPatern keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [objectManager addResponseDescriptor:responseMarketPaginationNote];
    [objectManager addResponseDescriptor:responseOnCreateNote];
    [objectManager addResponseDescriptor:responsePaginationNote];
}

+ (void)configureNotesUploadRequest:(RKObjectManager *)objectManager
{
    RKObjectMapping *notesMapping = [RKObjectMapping mappingForClass:[NSMutableDictionary class]];
    [notesMapping addAttributeMappingsFromDictionary:@{
     @"classID" : @"class_id",
     @"noteDescription" : @"description",
     @"price" : @"price",
     @"fullPrice" : @"full_access_price",
     @"tags" : @"tags",
     @"pdfUrl" : @"pdf_url",
     @"arrayOfURLs" :@"images_urls",
     @"thumbnail" : @"thumbnail",
     }];
    RKRequestDescriptor *noteRequestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:notesMapping objectClass:[CCNoteUploadInfo class] rootKeyPath:nil];
    [objectManager addRequestDescriptor:noteRequestDescriptor];

}

+ (RKObjectMapping *)paginationMapping
{
    RKObjectMapping *paginationResponseMapping  = [RKObjectMapping mappingForClass:[NSMutableDictionary class]];
    
    [paginationResponseMapping addAttributeMappingsFromDictionary:@{@"count": CCResponseKeys.count}];
    return paginationResponseMapping;
}

+ (void)configureAttachmentResponse:(RKObjectManager *)objectManager
{
    RKObjectMapping *notesLinkMaping = [RKObjectMapping mappingForClass:[NSMutableDictionary class]];
    [notesLinkMaping addAttributeMappingsFromDictionary:@{
        @"note_url" : @"link",
     }];
    
    NSString *pathPattern = [NSString stringWithFormat:CCAPIDefines.notesAttachmentURL,@":noteID"];
    
    RKResponseDescriptor *noteAttacmentDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:notesLinkMaping pathPattern:pathPattern keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [objectManager addResponseDescriptor:noteAttacmentDescriptor];
}

+ (void)configureNotesPurchasingResponse:(RKObjectManager *)objectManager
{
    RKObjectMapping *notesPurchasingResponse = [RKObjectMapping mappingForClass:[NSMutableDictionary class]];
    [notesPurchasingResponse addAttributeMappingsFromDictionary:@{
        @"success" : @"success",
     }];
    
    NSString *pathPattern = [NSString stringWithFormat:CCAPIDefines.purchaseNote,@":noteID"];
    
    RKResponseDescriptor *notesPurchasingResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:notesPurchasingResponse pathPattern:pathPattern keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    NSString *resendLinkPathPattern = [NSString stringWithFormat:CCAPIDefines.resendLinkToNote,@":note"];
    
    RKResponseDescriptor *notesResendingLinkResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:notesPurchasingResponse pathPattern:resendLinkPathPattern keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [objectManager addResponseDescriptor:notesPurchasingResponseDescriptor];
    [objectManager addResponseDescriptor:notesResendingLinkResponseDescriptor];
}

@end
