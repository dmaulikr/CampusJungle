//
//  CCSettingsAPIProviderProtocol.h
//  CampusJungle
//
//  Created by Vlad Korzun on 02.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCSettings.h"
#import "CCTypesDefinition.h"

@protocol CCSettingsAPIProviderProtocol <AppleGuiceInjectable>

- (void)getSettingsSuccessHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;

- (void)uploadSettings:(CCSettings *)settings successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;

@end
