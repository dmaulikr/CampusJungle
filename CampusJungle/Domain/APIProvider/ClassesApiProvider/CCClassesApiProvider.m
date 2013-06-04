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
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [self setAuthorizationToken];
    
    NSDictionary *parametersArray =  @{@"professor":class.professor,@"subject":class.subject,@"timetable":class.timetable,@"semester":@"2"};

    [objectManager postObject:nil
                         path:[NSString stringWithFormat:CCAPIDefines.createClass,class.collegeID]
                   parameters:parametersArray
                      success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                          successHandler(mappingResult);
                      }
                      failure:^(RKObjectRequestOperation *operation, NSError *error) {
                          errorHandler(error);
                      }];
}

@end
