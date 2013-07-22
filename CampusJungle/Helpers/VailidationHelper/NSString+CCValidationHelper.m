//
//  NSString+CCValidationHelper.m
//  CampusJungle
//
//  Created by Vlad Korzun on 23.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "NSString+CCValidationHelper.h"

@implementation NSString (CCValidationHelper)

- (BOOL)isValidEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:self];
}

@end
