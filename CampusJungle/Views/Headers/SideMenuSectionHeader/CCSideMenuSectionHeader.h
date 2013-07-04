//
//  CCSideMenuSectionHeader.h
//  CampusJungle
//
//  Created by Yury Grinenko on 03.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCSideMenuSectionHeader : UIView

- (id)initWithText:(NSString *)text;
+ (CGFloat)heightForHeaderWithText:(NSString *)text;

@end
