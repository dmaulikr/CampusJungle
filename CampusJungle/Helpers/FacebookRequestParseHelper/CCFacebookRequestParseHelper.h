//
//  CCFacebookRequestParseHelper.h
//  CampusJungle
//
//  Created by Yury Grinenko on 29.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCFacebookRequestParseHelper : NSObject

+ (NSDictionary*)parseURLParams:(NSString *)query;

@end
