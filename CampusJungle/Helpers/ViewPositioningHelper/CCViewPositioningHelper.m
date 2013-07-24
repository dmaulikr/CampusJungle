//
//  CCViewPositioningHelper.m
//  CampusJungle
//
//  Created by Yury Grinenko on 04.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCViewPositioningHelper.h"

@implementation CCViewPositioningHelper

+ (void)setOriginX:(CGFloat)originX toView:(UIView *)view {
    CGRect newFrame = [view frame];
    newFrame.origin.x = originX;
    [view setFrame:newFrame];
}

+ (void)setOriginY:(CGFloat)originY toView:(UIView *)view {
    CGRect newFrame = [view frame];
    newFrame.origin.y = originY;
    [view setFrame:newFrame];
}

+ (void)setWidth:(CGFloat)width toView:(UIView *)view {
    CGRect newFrame = [view frame];
    newFrame.size.width = width;
    [view setFrame:newFrame];
}

+ (void)setHeight:(CGFloat)height toView:(UIView *)view {
    CGRect newFrame = [view frame];
    newFrame.size.height = height;
    [view setFrame:newFrame];
}

+ (void)setCenterX:(CGFloat)centerX toView:(UIView *)view {
    CGPoint newCenter = view.center;
    newCenter.x = centerX;
    [view setCenter:newCenter];
}

+ (void)setCenterY:(CGFloat)centerY toView:(UIView *)view {
    CGPoint newCenter = view.center;
    newCenter.y = centerY;
    [view setCenter:newCenter];
}

+ (CGFloat)bottomOfView:(UIView *)view
{
    return view.frame.origin.y + view.frame.size.height;
}

+ (CGFloat)rightSideOfView:(UIView *)view
{
    return view.frame.origin.x + view.frame.size.width;
}

@end
