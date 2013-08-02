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
#import "CCButtonsHelper.h"

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
    if(self.reportButtonContainer){
        [self addReportButton];
    }
}

- (void)addReportButton
{
    self.reportButton = [[UIButton alloc] initWithFrame:self.reportButtonContainer.bounds];
    [self.reportButtonContainer addSubview:self.reportButton];
    self.reportButtonContainer.backgroundColor = [UIColor clearColor];
    [self.reportButton setTitle:@"Report this" forState:UIControlStateNormal];
    self.reportButton.titleLabel.font = [UIFont fontWithName:@"Avenir-Oblique" size:20];
    [self.reportButton setTitleColor:[UIColor colorWithRed:130./255 green:65./255 blue:0 alpha:1] forState:UIControlStateNormal];
    [self.reportButton setTitleColor:[UIColor colorWithRed:31./255 green:163./255 blue:0 alpha:1] forState:UIControlStateHighlighted];
    
    [self.reportButton addTarget:self action:@selector(reportButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [CCButtonsHelper removeBackgroundImageInButton:self.reportButton];
}

- (void)reportButtonPressed
{
    if ([self respondsToSelector:@selector(cellObject)]){
        [self.reportDelegate postReportOnContent:[self valueForKey:@"cellObject"]];
    }
}

- (void)addBottomDivider
{
    self.bottomDivider = [[UIImageView alloc] initWithFrame:CGRectMake(kDividerPadding, self.bounds.size.height - kDividerHeight, self.bounds.size.width - 2 * kDividerPadding, kDividerHeight)];
    [self.bottomDivider setBackgroundColor:BASE_DIVIDER_COLOR];
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
