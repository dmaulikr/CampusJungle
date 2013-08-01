//
//  CCSettingsTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 01.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCSettingsTransaction.h"
#import "CCSettingController.h"

@implementation CCSettingsTransaction

- (void)perform
{
    NSParameterAssert(self.navigation);
    CCSettingController *settingsController = [CCSettingController new];
    
    [self.navigation pushViewController:settingsController animated:YES];
}

@end
