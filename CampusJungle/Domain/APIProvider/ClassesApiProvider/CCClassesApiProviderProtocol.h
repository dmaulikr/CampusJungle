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
@end
