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

#import "CCRestKitConfigurator.h"

@implementation CCLocation

- (NSString *)modelType
{
    return CCModelsTypes.location;
}

- (NSString *)modelID
{
    return self.locationId;
}

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

+ (CCLocation *)createWithCoordinates:(CLLocationCoordinate2D)coordinates name:(NSString *)name description:(NSString *)description address:(NSString *)address place:(id)place visibleItems:(NSArray *)visibleItemsArray sharedWithAll:(BOOL)sharedWithAll
{
    CCLocation *location = [CCLocation new];
    
    location.latitude = coordinates.latitude;
    location.longitude = coordinates.longitude;
    location.name = name;
    location.address = address;
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

+ (void)configureMappingWithManager:(RKObjectManager *)objectManager
{
    [self configureLocationsResponse:objectManager];
    [self configureLocationsRequest:objectManager];
}

+ (void)configureLocationsResponse:(RKObjectManager *)objectManager
{
    RKObjectMapping *paginationLocationsResponseMapping = [CCRestKitConfigurator paginationMapping];
    RKObjectMapping *locationsResponseMapping = [RKObjectMapping mappingForClass:[CCLocation class]];
    [locationsResponseMapping addAttributeMappingsFromDictionary:[CCLocation responseMappingDictionary]];
    RKRelationshipMapping *relationshipResponseLocationsMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:CCResponseKeys.items
                                                                                                              toKeyPath:CCResponseKeys.items
                                                                                                            withMapping:locationsResponseMapping];
    
    
    [paginationLocationsResponseMapping addPropertyMapping:relationshipResponseLocationsMapping];
    
    NSString *classPathPattern = [NSString stringWithFormat:CCAPIDefines.classLocations, @":classID"];
    RKResponseDescriptor *classLocationsResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:paginationLocationsResponseMapping
                                                                                                     pathPattern:classPathPattern
                                                                                                         keyPath:nil
                                                                                                     statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    NSString *groupPathPattern = [NSString stringWithFormat:CCAPIDefines.groupLocations, @":groupID"];
    RKResponseDescriptor *groupLocationsResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:paginationLocationsResponseMapping
                                                                                                     pathPattern:groupPathPattern
                                                                                                         keyPath:nil
                                                                                                     statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];

    [objectManager addResponseDescriptor:classLocationsResponseDescriptor];
    [objectManager addResponseDescriptor:groupLocationsResponseDescriptor];
}

+ (void)configureLocationsRequest:(RKObjectManager *)objectManager
{
    RKObjectMapping *locationMapping = [RKObjectMapping mappingForClass:[NSMutableDictionary class]];
    [locationMapping addAttributeMappingsFromDictionary:[CCLocation requestMappingDictionary]];
    RKRequestDescriptor *locationRequestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:locationMapping objectClass:[CCLocation class] rootKeyPath:nil];
    [objectManager addRequestDescriptor:locationRequestDescriptor];
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
         @"address" : @"address"
      };
}

+ (NSDictionary *)requestMappingDictionary
{
    return @{
         @"description" : @"description",
         @"name" : @"name",
         @"latitude" : @"latitude",
         @"longitude" : @"longitude",
         @"address" : @"address",
         @"sharedWithAll" : @"shared_with_all",
         @"visibleUsersIdsArray" : @"users_ids",
         @"visibleGroupsIdsArray" : @"groups_ids"
     };
}

@end
