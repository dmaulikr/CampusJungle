//
//  CCGroupTabbarDelegate.h
//  CampusJungle
//
//  Created by Yury Grinenko on 22.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CCGroupTabbarDelegate <NSObject>

- (void)didSelectBarItemWithIdentifier:(NSInteger)identifier;
- (void)didReselectBarItemWithIdentifier:(NSInteger)identifier;

@end
