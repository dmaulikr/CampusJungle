//
//  CCBaseCell.m
//  CampusJungle
//
//  Created by Vlad Korzun on 03.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCBaseCell.h"

@implementation CCBaseCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        if ([[NSBundle mainBundle] pathForResource:NSStringFromClass([self class]) ofType:@"nib"] != nil)
        {
            self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class])
                                                  owner:self
                                                options:nil] objectAtIndex:0];
        }
    }
    return self;
}

- (void)setSelectionColor
{
    UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SelectionBackGround.png"]];
    [self setSelectedBackgroundView:bgView];
}

+ (CGFloat)heightForCellWithObject:(id)object
{
    return defaultCellHeight;
}

@end
