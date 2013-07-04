//
//  CCSideMenuSectionHeader.h
//  CampusJungle
//
//  Created by Yury Grinenko on 03.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CCSideMenuDelegate;

@interface CCSideMenuSectionHeader : UIView

- (id)initWithText:(NSString *)text delegate:(id<CCSideMenuDelegate>)delegate;
+ (CGFloat)heightForHeaderWithText:(NSString *)text;

@end
