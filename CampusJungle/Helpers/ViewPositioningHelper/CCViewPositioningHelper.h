//
//  CCViewPositioningHelper.h
//  CampusJungle
//
//  Created by Yury Grinenko on 04.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCViewPositioningHelper : NSObject

+ (void)setOriginX:(CGFloat)originX toView:(UIView *)view;
+ (void)setOriginY:(CGFloat)originY toView:(UIView *)view;
+ (void)setWidth:(CGFloat)width toView:(UIView *)view;
+ (void)setHeight:(CGFloat)height toView:(UIView *)view;
+ (void)setCenterX:(CGFloat)centerX toView:(UIView *)view;
+ (void)setCenterY:(CGFloat)centerY toView:(UIView *)view;
+ (CGFloat)bottomOfView:(UIView *)view;

@end
