//
//  CCPluralizeHelper.m
//  CampusJungle
//
//  Created by Yury Grinenko on 15.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCPluralizeHelper.h"

@implementation CCPluralizeHelper

+ (NSString *)pluralizeEntityName:(NSString *)entityName withNumberOfItems:(NSInteger)itemsNumber
{
    if (itemsNumber == 1) {
        return entityName;
    }
    return [NSString stringWithFormat:@"%@s", entityName];
}

@end
