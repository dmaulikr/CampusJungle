//
//  CCBaseCell.m
//  CampusJungle
//
//  Created by Vlad Korzun on 03.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

static const NSInteger kDividerPadding = 10;
static const NSInteger kDividerHeight = 1;

#import "CCBaseCell.h"
#import "CCViewPositioningHelper.h"

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

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self addBottomDivider];
}

- (void)addBottomDivider
{
    self.bottomDivider = [[UIImageView alloc] initWithFrame:CGRectMake(kDividerPadding, self.bounds.size.height - kDividerHeight, self.bounds.size.width - 2 * kDividerPadding, kDividerHeight)];
    [self.bottomDivider setBackgroundColor:[UIColor colorWithRed:130.0/255.0 green:65.0/255.0 blue:0.0 alpha:1]];
    [self.bottomDivider setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin];
    [self addSubview:self.bottomDivider];
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
