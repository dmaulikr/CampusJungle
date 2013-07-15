//
//  CCClass.m
//  CampusJungle
//
//  Created by Yulia Petryshena on 6/3/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCClass.h"

@implementation CCClass

- (NSString *)name
{
    return self.subject;
}

- (NSString *)description
{
    return self.subject;
}

+ (void)configureMappingWithManager:(RKObjectManager *)objectManager
{
    [self configureClassesInCollegesResponse:objectManager];
    [self configureClassResponce:objectManager];
}

+ (void)configureClassResponce:(RKObjectManager *)objectManager
{
    RKObjectMapping* classResponseMapping = [RKObjectMapping mappingForClass:[CCClass class]];
    
    [classResponseMapping addAttributeMappingsFromDictionary:[CCClass responseMappingDictionary]];
    
    RKObjectMapping *classRequestMapping = [RKObjectMapping mappingForClass:[NSMutableDictionary class]];
    [classRequestMapping addAttributeMappingsFromDictionary:[CCClass requestMappingDictionary]];
    
    
    RKRequestDescriptor *classRequestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:classRequestMapping objectClass:[CCClass class] rootKeyPath:nil];
    
    NSString *classPathPatern = [NSString stringWithFormat:CCAPIDefines.createClass,@":college_id"];
    NSString *classesCollegePathPatern = [NSString stringWithFormat:CCAPIDefines.classesOfCollege,@":college_id"];
    NSString *joinClass = [NSString stringWithFormat:CCAPIDefines.addClass,@":class_id"];
    
    
    
    RKResponseDescriptor *responseNewClassDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:classResponseMapping
                                                                                               pathPattern:classPathPatern
                                                                                                   keyPath:@"class"
                                                                                               statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    
    RKResponseDescriptor *responseAllClassesDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:classResponseMapping
                                                                                                 pathPattern:CCAPIDefines.allClasses
                                                                                                     keyPath:@"classes"
                                                                                                 statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    RKResponseDescriptor *responseClassesOfCollegeDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:classResponseMapping
                                                                                                       pathPattern:classesCollegePathPatern
                                                                                                           keyPath:@"items"
                                                                                                       statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    RKResponseDescriptor *responseAddClassDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:classResponseMapping
                                                                                               pathPattern:joinClass
                                                                                                   keyPath:@"classes"
                                                                                               statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [objectManager addResponseDescriptor:responseAddClassDescriptor];
    [objectManager addResponseDescriptor:responseClassesOfCollegeDescriptor];
    [objectManager addResponseDescriptor:responseNewClassDescriptor];
    [objectManager addResponseDescriptor:responseAllClassesDescriptor];
    [objectManager addRequestDescriptor:classRequestDescriptor];
}


+ (void)configureClassesInCollegesResponse:(RKObjectManager *)objectManager
{
    RKObjectMapping *classesInCollegesResponseMapping = [RKObjectMapping mappingForClass:[NSMutableDictionary class]];
    [classesInCollegesResponseMapping addAttributeMappingsFromDictionary:@{
     @"college_name" : @"collegeName",
     @"college_id" : @"collegeId"
     }];
    
    RKObjectMapping *classesMapping = [RKObjectMapping mappingForClass:[CCClass class]];
    [classesMapping addAttributeMappingsFromDictionary:[CCClass responseMappingDictionary]];
    RKRelationshipMapping *classesToCollegeRelationMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:@"classes" toKeyPath:@"classes" withMapping:classesMapping];
    
    [classesInCollegesResponseMapping addPropertyMapping:classesToCollegeRelationMapping];
    
    NSString *pathPattern = CCAPIDefines.classesInColleges;
    
    RKResponseDescriptor *classesInCollegesResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:classesInCollegesResponseMapping pathPattern:pathPattern keyPath:@"classes_in_colleges" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [objectManager addResponseDescriptor:classesInCollegesResponseDescriptor];
}

+ (NSDictionary *)responseMappingDictionary
{
   return @{
      @"professor" : @"professor",
      @"timetable" : @"timetable",
      @"subject" : @"subject",
      @"semester" : @"semester",
      @"call_number":@"callNumber",
      @"id":@"classID",
      @"college_name" : @"collegeName",
      @"college_id" : @"collegeID",
      };
}

+ (NSDictionary *)requestMappingDictionary
{
    return @{
      @"professor" : @"professor",
      @"timetable" : @"timetable",
      @"subject" : @"subject",
      @"semester" : @"semester",
      @"call_number":@"callNumber",
      @"id":@"classID",
      @"college_name" : @"collegeName",
      };
}

@end
