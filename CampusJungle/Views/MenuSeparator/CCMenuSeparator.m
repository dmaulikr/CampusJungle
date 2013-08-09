//
//  CCMenuSeparator.m
//  CampusJungle
//
//  Created by Vlad Korzun on 09.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCMenuSeparator.h"

@implementation CCMenuSeparator

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"CCMenuSeparator" owner:self options:nil][0];
    }
    return self;
}


@end
