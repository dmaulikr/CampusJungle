//
//  CCTwitterPicker.h
//  CampusJungle
//
//  Created by Vlad Korzun on 28.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTypesDefinition.h"

@interface CCTwitterPicker : NSObject

+ (void)showTwitterAccountSelectionInView:(UIView *)view
                        startLoadingBlock:(action)startLaoding
                  fetchInfoSuccessHandler:(successWithObject)successHandler
                             errorHandler:(errorHandler)errorHandler;

@end
