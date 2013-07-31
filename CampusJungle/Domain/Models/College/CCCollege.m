//
//  CCCollege.m
//  CampusJungle
//
//  Created by Vlad Korzun on 29.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCCollege.h"
#import "CCRestKitConfigurator.h"

@implementation CCCollege

- (NSString *)modelId
{
    return self.collegeID;
}

+ (void)configureMappingWithManager:(RKObjectManager *)objectManager
{
    [self configureCollegeResponse:objectManager];
}

+ (void)configureCollegeResponse:(RKObjectManager *)objectManager
{
    RKObjectMapping *collegesMapping = [RKObjectMapping mappingForClass:[CCCollege class]];
    [collegesMapping addAttributeMappingsFromDictionary:[CCCollege responseMappingDictionary]];
    
    RKRelationshipMapping *relationShipResponseCollegesMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:CCResponseKeys.items
                                                                                                             toKeyPath:CCResponseKeys.items
                                                                                                           withMapping:collegesMapping];
    
    RKRelationshipMapping *relationShipResponseCollegeMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:@"college"
                                                                                                            toKeyPath:CCResponseKeys.item
                                                                                                          withMapping:collegesMapping];
    
    RKObjectMapping *paginationCollegesResponseMapping = [CCRestKitConfigurator paginationMapping];
    
    [paginationCollegesResponseMapping addPropertyMapping:relationShipResponseCollegeMapping];
    
    [paginationCollegesResponseMapping addPropertyMapping:relationShipResponseCollegesMapping];
    
    NSString *collegePathPatern = [NSString stringWithFormat:CCAPIDefines.colleges,@":colleges"];
    RKResponseDescriptor *responsePaginationCollege = [RKResponseDescriptor responseDescriptorWithMapping:paginationCollegesResponseMapping pathPattern:collegePathPatern keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    RKResponseDescriptor *responsePaginationCollegeSearch = [RKResponseDescriptor responseDescriptorWithMapping:paginationCollegesResponseMapping pathPattern:@"/api/colleges" keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [objectManager addResponseDescriptor:responsePaginationCollege];
    [objectManager addResponseDescriptor:responsePaginationCollegeSearch];
}

+ (NSDictionary *)responseMappingDictionary
{
    return @{
      @"id" : @"collegeID",
      @"name" : @"name",
      @"address" : @"address"
    };
}

@end
