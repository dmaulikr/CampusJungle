//
//  UITextField+InsetFixing.m
//  CampusJungle
//
//  Created by Vlad Korzun on 28.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "UITextField+InsetFixing.h"
#define standardTextFieldMargin 15
#define searchMargin 22

@implementation UITextField (InsetFixing)


- (CGRect)textRectForBounds:(CGRect)bounds {
    int margin = standardTextFieldMargin;
       if([self isKindOfClass:NSClassFromString(@"UISearchBarTextField")]){
           margin = searchMargin;
       }
    CGRect inset = CGRectMake(bounds.origin.x + margin, bounds.origin.y, bounds.size.width - margin * 2, bounds.size.height);
    return inset;
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    int margin = standardTextFieldMargin;
    if([self isKindOfClass:NSClassFromString(@"UISearchBarTextField")]){
        [self setFont:[UIFont fontWithName:@"Avenir-MediumOblique" size:15]];

        if(![self.textColor isEqual:[UIColor colorWithRed:130.0/255.0 green:65.0/255.0 blue:0.0 alpha:1]]){
            [self setTextColor:[UIColor colorWithRed:130.0/255.0 green:65.0/255.0 blue:0.0 alpha:1]];
        }
        margin = searchMargin;
    }
    CGRect inset = CGRectMake(bounds.origin.x + margin, bounds.origin.y, bounds.size.width - margin * 2, bounds.size.height);
    return inset;
}



@end
