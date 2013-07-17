//
//  CCClassesApiProviderProtocol.h
//  CampusJungle
//
//  Created by Yulia Petryshena on 6/4/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCClass.h"
#import "CCTypesDefinition.h"

@protocol CCClassesApiProviderProtocol <AppleGuiceInjectable,AppleGuiceSingleton>

- (void)createClass:(CCClass *)class successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;
- (void)getAllClasesSuccessHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;
- (void)getClassesOfCollege:(NSString*)collegeID successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;
- (void)joinClass:(NSString*)classID SuccessHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;
- (void)getClassesInCollegesWithSuccessHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;

- (void)leaveClassWithID:(NSString *)classID SuccessHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;
- (void)updateClass:(CCClass *)class successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;
@end
