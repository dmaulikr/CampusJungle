//
//  CCDateFormatterProtocol.h
//  CampusJungle
//
//  Created by Yury Grinenko on 17.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTypesDefinition.h"

@protocol CCDateFormatterProtocol <AppleGuiceInjectable, AppleGuiceSingleton>

- (NSString *)formatedDateStringFromDate:(NSDate *)date;

@end
