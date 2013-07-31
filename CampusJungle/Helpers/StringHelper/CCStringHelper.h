//
//  CCStringHelper.h
//  CampusJungle
//
//  Created by Yury Grinenko on 15.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCStringHelper : NSObject

+ (NSString *)trimSpacesFromString:(NSString *)string;
+ (NSString *)removeServiceSymbolsFromDeviceTokenString:(NSString *)string;

@end
