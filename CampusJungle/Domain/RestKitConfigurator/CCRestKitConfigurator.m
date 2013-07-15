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

#import <objc/runtime.h>
#import "CCRestKitMappableModel.h"

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
    Class *classes = NULL;
    int numClasses = objc_getClassList(NULL, 0);
    if (numClasses > 0 ) {
        classes = (__unsafe_unretained Class *)malloc(sizeof(Class) * numClasses);
        numClasses = objc_getClassList(classes, numClasses);
        for (int index = 0; index < numClasses; index++) {
            Class class = classes[index];
            if (class_conformsToProtocol(class, @protocol(CCRestKitMappableModel))) {
                [class performSelector:@selector(configureMappingWithManager:) withObject:objectManager];
            }
        }
        free(classes);
    }
}

+ (RKObjectMapping *)paginationMapping
{
    RKObjectMapping *paginationResponseMapping  = [RKObjectMapping mappingForClass:[NSMutableDictionary class]];
    [paginationResponseMapping addAttributeMappingsFromDictionary:@{@"count": CCResponseKeys.count}];
    return paginationResponseMapping;
}

@end
