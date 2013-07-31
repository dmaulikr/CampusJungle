//
//  CCCity.m
//  CampusJungle
//
//  Created by Vlad Korzun on 29.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCCity.h"
#import "CCRestKitConfigurator.h"

@implementation CCCity

- (NSString *)modelId
{
    return self.cityID;
}

+ (void)configureMappingWithManager:(RKObjectManager *)objectManager
{
    [self configureCityResponse:objectManager];
}

+ (void)configureCityResponse:(RKObjectManager *)objectManager
{
    RKObjectMapping *paginationCitiesResponseMapping = [CCRestKitConfigurator paginationMapping];
    RKObjectMapping *citiesMapping = [RKObjectMapping mappingForClass:[CCCity class]];
    
    [citiesMapping addAttributeMappingsFromDictionary:[CCCity responseMappingDictionary]];
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

+ (NSDictionary *)responseMappingDictionary
{
    return @{
      @"id" : @"cityID",
      @"name" : @"name"
    };
}

@end
