//
//  CCMapHelper.m
//  CampusJungle
//
//  Created by Yury Grinenko on 09.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCMapHelper.h"
#import "CCLocation.h"

@implementation CCMapHelper

+ (void)createAnnotationsOnMap:(MKMapView *)mapView withLocationsArray:(NSArray *)locationsArray
{
    MKMapRect zoomRect = MKMapRectNull;
    for (CCLocation *location in locationsArray) {
        CLLocationCoordinate2D annotationCoord = [self coordinatesForLocation:location];
        
        MKPointAnnotation *pointAnnotation = [[MKPointAnnotation alloc] init];
        pointAnnotation.coordinate = annotationCoord;
        pointAnnotation.title = location.name;
        pointAnnotation.subtitle = location.description;
        [mapView addAnnotation:pointAnnotation];
        
        MKMapPoint annotationPoint = MKMapPointForCoordinate(pointAnnotation.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.1, 0.1);
        zoomRect = MKMapRectUnion(zoomRect, pointRect);
    }
    [mapView setVisibleMapRect:zoomRect animated:YES];
}

+ (void)focusOnLocation:(CCLocation *)location inMap:(MKMapView *)mapView
{
    CLLocationCoordinate2D coordinates = [self coordinatesForLocation:location];
    MKMapPoint annotationPoint = MKMapPointForCoordinate(coordinates);
    MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.1, 0.1);
    [mapView setVisibleMapRect:pointRect animated:YES];
}

+ (CLLocationCoordinate2D)coordinatesForLocation:(CCLocation *)location
{
    CLLocationCoordinate2D locationCoord;
    locationCoord.latitude = location.latitude;
    locationCoord.longitude = location.longitude;
    return locationCoord;
}

@end
