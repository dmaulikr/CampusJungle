//
//  CCForum.h
//  CampusJungle
//
//  Created by Yury Grinenko on 15.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCForum : NSObject

@property (nonatomic, strong) NSString *forumId;
@property (nonatomic, strong) NSString *ownerId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *classId;
@property (nonatomic, assign) NSInteger questionsCount;
@property (nonatomic, strong) NSArray *questionsArray;

+ (NSDictionary *)responseMappingDictionary;
+ (NSDictionary *)requestMappingDictionary;

@end
