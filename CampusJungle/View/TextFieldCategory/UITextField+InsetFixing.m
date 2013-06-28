//
//  UITextField+InsetFixing.m
//  CampusJungle
//
//  Created by Vlad Korzun on 28.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "UITextField+InsetFixing.h"

@implementation UITextField (InsetFixing)

- (CGRect)textRectForBounds:(CGRect)bounds {
    int margin = 17;
    CGRect inset = CGRectMake(bounds.origin.x + margin, bounds.origin.y, bounds.size.width - margin, bounds.size.height);
    return inset;
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    int margin = 17;
    CGRect inset = CGRectMake(bounds.origin.x + margin, bounds.origin.y, bounds.size.width - margin, bounds.size.height);
    return inset;
}

@end
