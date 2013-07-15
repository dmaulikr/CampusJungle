//
//  CCRestKitConfigurator.m
//  CollegeConnect
//
//  Created by Vlad Korzun on 15.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCRestKitConfigurator.h"
#import <RestKit/RestKit.h>
#import "CCStandardErrorHandler.h"

#import "CCUser.h"
#import "CCAuthorization.h"
#import "CCPaginationResponse.h"
#import "CCState.h"
#import "CCCity.h"
#import "CCCollege.h"
#import "CCClass.h"
#import "CCNote.h"
#import "CCStuff.h"
#import "CCPhoto.h"
#import "CCOffer.h"
#import "CCMessage.h"
#import "CCLocation.h"
#import "CCReview.h"
#import "CCGroup.h"
#import "CCForum.h"

@implementation CCRestKitConfigurator

+ (void)configure
{
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    RKObjectManager *objectManager = [self objectManager];
    [self configureAllModelsWithObjectManager:objectManager];
}

+ (RKObjectManager *)objectManager
{
    NSURL *baseURL = [NSURL URLWithString:CCAPIDefines.baseURL];
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    [client setDefaultHeader:@"Accept" value:RKMIMETypeJSON];
    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
    [objectManager.HTTPClient setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusNotReachable) {
            [CCStandardErrorHandler showErrorWithTitle:CCAlertsMessages.error message:CCAlertsMessages.noInternetConnection];
        }
    }];
    return objectManager;
}

+ (void)configureAllModelsWithObjectManager:(RKObjectManager *)objectManager
{
    [CCUser configureMappingWithManager:objectManager];
    [CCClass configureMappingWithManager:objectManager];
    [CCCollege configureMappingWithManager:objectManager];
    [CCCity configureMappingWithManager:objectManager];
    [CCState configureMappingWithManager:objectManager];
    [CCAuthorization configureMappingWithManager:objectManager];
    [CCNote configureMappingWithManager:objectManager];
    [CCStuff configureMappingWithManager:objectManager];
    [CCOffer configureMappingWithManager:objectManager];
    [CCLocation configureMappingWithManager:objectManager];
    [CCMessage configureMappingWithManager:objectManager];
    [CCReview configureMappingWithManager:objectManager];
    [CCGroup configureMappingWithManager:objectManager];
    [CCForum configureMappingWithManager:objectManager];
}

+ (RKObjectMapping *)paginationMapping
{
    RKObjectMapping *paginationResponseMapping  = [RKObjectMapping mappingForClass:[NSMutableDictionary class]];
    [paginationResponseMapping addAttributeMappingsFromDictionary:@{@"count": CCResponseKeys.count}];
    return paginationResponseMapping;
}

@end
