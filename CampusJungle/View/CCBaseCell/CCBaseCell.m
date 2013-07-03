//
//  CCBaseCell.m
//  CampusJungle
//
//  Created by Vlad Korzun on 03.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCBaseCell.h"

@implementation CCBaseCell

- (void)setSelectionColor
{
    UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SelectionBackGround"]];
    [self setSelectedBackgroundView:bgView];
}

@end
