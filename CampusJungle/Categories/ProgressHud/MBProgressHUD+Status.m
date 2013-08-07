//
//  MBProgressHUD+Status.m
//  CampusJungle
//
//  Created by Yury Grinenko on 06.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "MBProgressHUD+Status.h"

@implementation MBProgressHUD (Status)

+ (void)showInKeyWindowWithStatus:(NSString *)status
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:[UIApplication sharedApplication].keyWindow];
    [hud setLabelText:status];
    [[UIApplication sharedApplication].keyWindow addSubview:hud];
    [hud show:YES];
}

+ (void)hideInKeyWindow
{
    [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
}

@end
