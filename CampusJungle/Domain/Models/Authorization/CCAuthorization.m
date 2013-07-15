//
//  CCAuthorization.m
//  CollegeConnect
//
//  Created by Vlad Korzun on 21.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAuthorization.h"

@implementation CCAuthorization

+ (void)configureMappingWithManager:(RKObjectManager *)objectManager
{
    [self configureFacebookLinking:objectManager];
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

@end
