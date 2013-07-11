//
//  CCKeyboardHepler.m
//  CampusJungle
//
//  Created by Yury Grinenko on 11.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCKeyboardHepler.h"

@implementation CCKeyboardHepler

+ (void)hideKeyboard
{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

@end
