//
//  UITextField+InsetFixing.h
//  CampusJungle
//
//  Created by Vlad Korzun on 28.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (InsetFixing)

- (CGRect)textRectForBounds:(CGRect)bounds;

- (CGRect)editingRectForBounds:(CGRect)bounds;

@end
