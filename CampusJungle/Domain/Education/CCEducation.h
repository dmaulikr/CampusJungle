//
//  CCEducation.h
//  CampusJungle
//
//  Created by Vlad Korzun on 30.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCEducation : NSObject

@property (nonatomic, strong) NSString *collegeName;
@property (nonatomic, strong) NSString *graduationDate;
@property (nonatomic, strong) NSNumber *collegeID;
@property (nonatomic, strong) NSString *status;

+ (NSArray *)arrayOfCollegesIDFromEducations:(NSArray *)educations;
+ (NSArray *)arrayOfCollegesFromEducations:(NSArray *)educations;

- (BOOL)isEqualToEducation:(CCEducation *)education;

@end