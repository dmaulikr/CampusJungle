//
//  CCPhoto.h
//  CampusJungle
//
//  Created by Vlad Korzun on 21.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCPhoto : NSObject

@property (nonatomic, strong) NSString *thumbnail;
@property (nonatomic, strong) NSString *thumbnailRetina;
@property (nonatomic, strong) NSString *normal;

+ (NSDictionary *)responseMappingDictionary;

@end