//
//  CCEducation.m
//  CampusJungle
//
//  Created by Vlad Korzun on 30.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCEducation.h"

@implementation CCEducation

- (BOOL)isEqualToEducation:(CCEducation *)education
{
    if(![self.graduationDate isEqualToString:education.graduationDate] && (self.graduationDate || education.graduationDate) ){
        return NO;
    }
    if(![self.collegeName isEqualToString:education.collegeName]){
        return NO;
    }
    if(![self.collegeID.stringValue isEqualToString:education.collegeID.stringValue]){
        return NO;
    }
    return YES;
}

+ (NSArray *)arrayOfCollegesIDFromEducations:(NSArray *)educations
{
    NSMutableArray *colleges = [NSMutableArray new];
    for(CCEducation *education in educations){
        if(![CCEducation isID:[education.collegeID stringValue] alreadyExistIn:colleges]){
            [colleges addObject:[education.collegeID stringValue]];
        }
    }
    return colleges;
}

+ (BOOL)isID:(NSString *)collegeID alreadyExistIn:(NSArray *)collegeIds
{
    for (NSString *existCollegeID in collegeIds){
        if ([existCollegeID isEqualToString:collegeID]){
            return YES;
        }
    }
    return NO;
}

@end
