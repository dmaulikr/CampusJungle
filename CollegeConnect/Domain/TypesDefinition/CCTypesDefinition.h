//
//  CCTypesDefinition.h
//  CollegeConnect
//
//  Created by Vlad Korzun on 21.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

typedef void (^userInfoSuccessHandler)(NSDictionary *);
typedef void (^successHandler)();
typedef void (^errorHandler)(NSError *);
typedef void (^successHandlerWithRKResult)(RKMappingResult *);
typedef void (^RKErrorHandler)(RKObjectRequestOperation *operation, NSError *error);