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

@end
