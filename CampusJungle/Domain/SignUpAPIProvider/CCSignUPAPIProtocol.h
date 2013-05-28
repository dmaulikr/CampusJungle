//
//  CCSignUPAPIProtocol.h
//  CollegeConnect
//
//  Created by Vlad Korzun on 22.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCTypesDefinition.h"

@protocol CCSignUPAPIProtocol <NSObject>

- (void)signUpWithUserDictionary:(NSDictionary *)userInfo
                  successHandler:(successHandler)success
                    errorHandler:(errorHandler)error;
@end
