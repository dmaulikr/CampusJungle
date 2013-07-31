//
//  CCFeedback.h
//  CampusJungle
//
//  Created by Vlad Korzun on 26.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCRestKitMappableModel.h"

@interface CCFeedback : NSObject<CCRestKitMappableModel>

@property (nonatomic, strong) NSDictionary *currentStatistic;
@property (nonatomic, strong) NSDictionary *totalStatistic;
@property (nonatomic, strong) NSString *classID;

@end
