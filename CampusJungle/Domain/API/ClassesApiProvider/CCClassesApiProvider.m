//
//  CCClassesApiProvider.m
//  CampusJungle
//
//  Created by Yulia Petryshena on 6/4/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCClassesApiProvider.h"
#import "CCDefines.h"

@implementation CCClassesApiProvider

- (void)createClass:(CCClass *)class successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler
{
    NSLog(@"%@",class.timetable);
    [self postInfoWithObject:class
                   thumbnail:class.thumb
                      images:nil
                      onPath:[NSString stringWithFormat:CCAPIDefines.createClass,class.collegeID]
              successHandler:^(RKMappingResult *mappingResult) {
                  successHandler(mappingResult);
              }
                errorHandler:^(NSError *error) {
                    errorHandler(error);
                }
                    progress:^(double finished) {
                        
                    }];
}

- (void)updateClass:(CCClass *)class successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler
{
    [self putInfoWithObject:class
                   thumbnail:class.thumb
                      images:nil
                      onPath:[NSString stringWithFormat:CCAPIDefines.updateClass,class.classID]
              successHandler:^(RKMappingResult *mappingResult) {
                  successHandler(mappingResult);
              }
                errorHandler:^(NSError *error) {
                    errorHandler(error);
                }
                    progress:^(double finished) {
                        
                    }];
}


- (void)getClassesOfCollege:(NSString *)collegeID searchString:(NSString *)searchString successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler
{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [self setAuthorizationToken];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if ([searchString length] > 0) {
        [params setObject:searchString forKey:@"keywords"];
    }

    NSString *path = [NSString stringWithFormat:CCAPIDefines.classesOfCollege,collegeID];
    [objectManager getObjectsAtPath:path
                         parameters:params
                            success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                successHandler([mappingResult array]);
                            } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                errorHandler(error);
                            }];
}


- (void)getAllClasesSuccessHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler
{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [self setAuthorizationToken];
    
    [objectManager getObjectsAtPath:CCAPIDefines.allClasses
                         parameters:nil
                            success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                successHandler([mappingResult array]);
                            } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                errorHandler(error);
                            }];
}

- (void)joinClass:(NSString*)classID SuccessHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler
{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [self setAuthorizationToken];
    NSString *path = [NSString stringWithFormat:CCAPIDefines.addClass,classID];
    [objectManager putObject:nil
                        path:path
                  parameters:nil
                     success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                          successHandler(mappingResult.firstObject);
                     } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                             errorHandler(error);
                     }];
}

- (void)getClassesInCollegesWithSuccessHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler
{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [self setAuthorizationToken];
    
    [objectManager getObjectsAtPath:CCAPIDefines.classesInColleges
                         parameters:nil
                            success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                successHandler([mappingResult array]);
                            } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                errorHandler(error);
                            }];
}

- (void)leaveClassWithID:(NSString *)classID SuccessHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler
{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [self setAuthorizationToken];
    NSString *path = [NSString stringWithFormat: CCAPIDefines.leaveClass,classID];
    [objectManager deleteObject:nil path:path parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        successHandler(mappingResult);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        errorHandler(error);
    }];
}

@end
