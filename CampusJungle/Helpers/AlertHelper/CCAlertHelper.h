//
//  CCAlertHelper.h
//  CampusJungle
//
//  Created by Yury Grinenko on 15.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTypesDefinition.h"

@interface CCAlertHelper : NSObject

+ (void)showConfirmWithSuccess:(successHandler)success;

@end
