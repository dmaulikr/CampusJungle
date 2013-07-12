//
//  CCLocation.m
//  CampusJungle
//
//  Created by Yury Grinenko on 08.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCLocation.h"
#import "CCClass.h"
#import "CCGroup.h"
#import "CCUser.h"

@implementation CCLocation

+ (CCLocation *)createUsingLocation:(CLLocation *)clLocation
{
    return [self createWithCoordinates:clLocation.coordinate];
}

+ (CCLocation *)createWithCoordinates:(CLLocationCoordinate2D)coordinates
{
    CCLocation *location = [CCLocation new];
    location.latitude = coordinates.latitude;
    location.longitude = coordinates.longitude;
    return location;
}

+ (CCLocation *)createWithCoordinates:(CLLocationCoordinate2D)coordinates name:(NSString *)name description:(NSString *)description place:(id)place visibleItems:(NSArray *)visibleItemsArray sharedWithAll:(BOOL)sharedWithAll
{
    CCLocation *location = [CCLocation new];
    
    location.latitude = coordinates.latitude;
    location.longitude = coordinates.longitude;
    location.name = name;
    location.description = description;
    location.sharedWithAll = sharedWithAll;
    
    if ([place isKindOfClass:[CCClass class]]) {
        location.placeId = [(CCClass *)place classID];
    }
    else {
        location.placeId = [(CCGroup *)place groupId];
    }
    
    if ([[visibleItemsArray objectAtIndex:0] isKindOfClass:[CCUser class]]) {
        location.visibleUsersIdsArray = [visibleItemsArray valueForKeyPath:@"uid"];
    }
    else {
        location.visibleGroupsIdsArray = [visibleItemsArray valueForKeyPath:@"groupId"];
    }
    return location;
}

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
         @"sharedWithAll" : @"shared_with_all",
         @"visibleUsersIdsArray" : @"users_ids",
         @"visibleGroupsIdsArray" : @"groups_ids"
     };
}

@end
