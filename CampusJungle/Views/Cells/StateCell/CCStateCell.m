//
//  CCStateCell.m
//  CampusJungle
//
//  Created by Vlad Korzun on 29.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCStateCell.h"
#import "CCState.h"
#import "CCViewPositioningHelper.h"

static const NSInteger kMinCellHeight = 44;
static const NSInteger kDefaultTextLabelWidth = 293;
static const NSInteger kTextLabelOriginY = 10;
static const NSInteger kBottomSpace = 5;

@interface CCStateCell()

@property (nonatomic, weak) IBOutlet UILabel *stateNameLabel;

@end

@implementation CCStateCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setSelectionColor];
}

- (void)prepareForReuse
{
    [CCViewPositioningHelper setWidth:kDefaultTextLabelWidth toView:self.stateNameLabel];
}

- (void)setCellObject:(id)cellObject
{
    _cellObject = cellObject;
    self.stateNameLabel.text = [(CCState *)cellObject name];
}

+ (CGFloat)heightForCellWithObject:(CCState *)state
{
    UIFont *font = [UIFont fontWithName:@"Avenir-Heavy" size:15];
    CGSize requiredSize = [state.name sizeWithFont:font constrainedToSize:CGSizeMake(kDefaultTextLabelWidth, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    return MAX(kMinCellHeight, requiredSize.height + kTextLabelOriginY + kBottomSpace);
}

@end
