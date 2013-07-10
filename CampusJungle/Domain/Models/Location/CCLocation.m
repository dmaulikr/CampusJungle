//
//  CCLocation.m
//  CampusJungle
//
//  Created by Yury Grinenko on 08.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCLocation.h"

@implementation CCLocation

+ (NSDictionary *)responseMappingDictionary
{
    return @{
         @"id" : @"locationId",
         @"description" : @"description",
         @"name" : @"name",
         @"latitude" : @"latitude",
         @"longitude" : @"longitude",
         @"place_id" : @"placeId",
         @"place_type" : @"placeType",
         @"owner_id" : @"ownerId",
         @"shared_with_all" : @"sharedWithAll",
         @"city_id" : @"cityId",
         @"street" : @"street"
      };
}

+ (NSDictionary *)requestMappingDictionary
{
    return @{
         @"description" : @"description",
         @"name" : @"name",
         @"latitude" : @"latitude",
         @"longitude" : @"longitude",
         @"placeId" : @"place_id",
         @"placeType" : @"place_type",
         @"ownerId" : @"owner_id",
         @"sharedWithAll" : @"shared_with_all",
         @"cityId" : @"city_id",
         @"street" : @"street",
         @"users_ids" : @"visibleUsersIdsArray"
     };
}

@end
