//
//  CCClassTabbarControllerDelegateProtocol.h
//  CampusJungle
//
//  Created by Vlad Korzun on 08.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCDefines.h"

@protocol CCClassTabbarControllerDelegateProtocol <NSObject>

@optional
- (void)didSelectBarItemWithIdentifier:(NSInteger)identifier;
- (void)didReselectBarItemWithIdentifier:(NSInteger)identifier;

@end
