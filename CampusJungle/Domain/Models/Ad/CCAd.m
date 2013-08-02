//
//  CCAd.m
//  CampusJungle
//
//  Created by Yury Grinenko on 02.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAd.h"
#import "CCRestKitConfigurator.h"

@implementation CCAd

+ (void)configureMappingWithManager:(RKObjectManager *)objectManager
{
    [self configureAdResponse:objectManager];
}

+ (void)configureAdResponse:(RKObjectManager *)objectManager
{
    RKObjectMapping *paginationAdsResponseMapping = [CCRestKitConfigurator paginationMapping];
    
    RKObjectMapping *adsMapping = [RKObjectMapping mappingForClass:[CCAd class]];
    [adsMapping addAttributeMappingsFromDictionary:[CCAd responseMappingDictionary]];
    
    RKRelationshipMapping *relationShipResponseAdsMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:CCResponseKeys.items
                                                                                                                  toKeyPath:CCResponseKeys.items
                                                                                                                withMapping:adsMapping];
    
    [paginationAdsResponseMapping addPropertyMapping:relationShipResponseAdsMapping];
    
    NSString *pathPattern = [NSString stringWithFormat:CCAPIDefines.loadAds, @":classID"];
    RKResponseDescriptor *responseAdsDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:paginationAdsResponseMapping
                                            pathPattern:pathPattern
                                                keyPath:nil
                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [objectManager addResponseDescriptor:responseAdsDescriptor];
}

+ (NSDictionary *)responseMappingDictionary
{
    return @{
             @"id" : @"adId",
             @"name" : @"name",
             @"description" : @"description",
             @"latitude" : @"latitude",
             @"longitude" : @"longitude",
             @"radius" : @"radius",
             @"image_normalized" : @"normalizedImageUrl",
             @"image_original" : @"originalImageUrl"
             };
}

@end
