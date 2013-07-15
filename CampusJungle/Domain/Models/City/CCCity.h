//
//  CCCity.h
//  CampusJungle
//
//  Created by Vlad Korzun on 29.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCRestKitMappableModel.h"

@interface CCCity : NSObject <CCRestKitMappableModel>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *cityID;

@end

