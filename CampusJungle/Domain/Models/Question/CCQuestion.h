//
//  CCQuestion.h
//  CampusJungle
//
//  Created by Yury Grinenko on 15.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCRestKitMappableModel.h"

@interface CCQuestion : NSObject <CCRestKitMappableModel>

@property (nonatomic, strong) NSString *questionId;
@property (nonatomic, strong) NSString *forumId;
@property (nonatomic, strong) NSString *ownerId;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *attachment;
@property (nonatomic, assign) NSInteger answersCount;

+ (NSDictionary *)responseMappingDictionary;
+ (NSDictionary *)requestMappingDictionary;

@end
