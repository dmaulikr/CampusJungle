//
//  CCTypesDefinition.h
//  CollegeConnect
//
//  Created by Vlad Korzun on 21.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <RestKit/RestKit.h>

typedef void (^userInfoSuccessHandler)(NSDictionary *);
typedef void (^successHandler)();
typedef void (^action)();
typedef void (^successWithObject)(id);
typedef void (^errorHandler)(NSError *);
typedef void (^successHandlerWithRKResult)(RKMappingResult *);
typedef void (^RKErrorHandler)(RKObjectRequestOperation *operation, NSError *error);
typedef void (^progressBlock)(double finished);