//
//  MBProgressHUD+Status.h
//  CampusJungle
//
//  Created by Yury Grinenko on 06.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBProgressHUD (Status)

+ (void)showInKeyWindowWithStatus:(NSString *)status;
+ (void)hideInKeyWindow;

@end
