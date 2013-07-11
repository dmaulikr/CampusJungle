//
//  CCPlacemarkAddressHelper.h
//  CampusJungle
//
//  Created by Yury Grinenko on 11.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCPlacemarkAddressHelper : NSObject

+ (NSString *)addressForPlacemark:(CLPlacemark *)placemark;

@end
