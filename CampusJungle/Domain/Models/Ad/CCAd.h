//
//  CCAd.h
//  CampusJungle
//
//  Created by Yury Grinenko on 02.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCRestKitMappableModel.h"

@interface CCAd : NSObject <CCRestKitMappableModel>

@property (nonatomic, strong) NSString *adId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSString *radius;
@property (nonatomic, strong) NSString *normalizedImageUrl;
@property (nonatomic, strong) NSString *originalImageUrl;

@end
