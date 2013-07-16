//
//  CCMapHelper.h
//  CampusJungle
//
//  Created by Yury Grinenko on 09.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CCLocation;

@interface CCMapHelper : NSObject

+ (void)createAnnotationsOnMap:(MKMapView *)mapView withLocationsArray:(NSArray *)locationsArray;
+ (void)makeVisibleAllLocations:(NSArray *)locationsArray onMap:(MKMapView *)mapView;
+ (void)focusOnLocation:(CCLocation *)location inMap:(MKMapView *)mapView;
+ (void)focusOnCLLocation:(CLLocation *)clLocation inMap:(MKMapView *)mapView;
+ (void)removeAllAnnotationsInMap:(MKMapView *)mapView;

@end
