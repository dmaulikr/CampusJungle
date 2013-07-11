//
//  CCLocation.h
//  CampusJungle
//
//  Created by Yury Grinenko on 08.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCLocation : NSObject

@property (nonatomic, strong) NSString *locationId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *cityId;
@property (nonatomic, strong) NSString *street;
@property (nonatomic, strong) NSString *ownerId;
@property (nonatomic, strong) NSString *placeId;
@property (nonatomic, strong) NSString *placeType;
@property (nonatomic, strong) NSArray *visibleUsersIdsArray;
@property (nonatomic, assign) BOOL sharedWithAll;

@property (nonatomic, assign) float latitude;
@property (nonatomic, assign) float longitude;

+ (NSDictionary *)responseMappingDictionary;
+ (NSDictionary *)requestMappingDictionary;
+ (CCLocation *)createUsingLocation:(CLLocation *)clLocation;
+ (CCLocation *)createWithCoordinates:(CLLocationCoordinate2D)coordinates;

@end
