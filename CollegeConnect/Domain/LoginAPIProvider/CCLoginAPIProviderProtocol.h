//
//  CCLoginAPIProviderProtocol.h
//  CollegeConnect
//
//  Created by Vlad Korzun on 21.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTypesDefinition.h"

@protocol CCLoginAPIProviderProtocol <AppleGuiceInjectable>

-(void)performLoginOperationViaFacebookWithSuccessHandler:(successHandler)successHandler errorHandler:(errorHandler)errorHandler;

@end
