//
//  CCLocation.h
//  CampusJungle
//
//  Created by Yury Grinenko on 08.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCRestKitMappableModel.h"

@interface CCLocation : NSObject <CCRestKitMappableModel>

@property (nonatomic, strong) NSString *locationId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *cityId;
@property (nonatomic, strong) NSString *street;
@property (nonatomic, strong) NSString *ownerId;
@property (nonatomic, strong) NSString *placeId;
@property (nonatomic, strong) NSString *placeType;
@property (nonatomic, strong) NSArray *visibleUsersIdsArray;
@property (nonatomic, strong) NSArray *visibleGroupsIdsArray;
@property (nonatomic, assign) BOOL sharedWithAll;

@property (nonatomic, assign) float latitude;
@property (nonatomic, assign) float longitude;

+ (CCLocation *)createUsingLocation:(CLLocation *)clLocation;
+ (CCLocation *)createWithCoordinates:(CLLocationCoordinate2D)coordinates;
+ (CCLocation *)createWithCoordinates:(CLLocationCoordinate2D)coordinates name:(NSString *)name description:(NSString *)description place:(id)place visibleItems:(NSArray *)visibleItemsArray sharedWithAll:(BOOL)sharedWithAll;

@end
