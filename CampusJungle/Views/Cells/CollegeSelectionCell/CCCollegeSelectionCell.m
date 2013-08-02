//
//  CCCollegeSellectionCell.m
//  CampusJungle
//
//  Created by Vlad Korzun on 29.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCCollegeSelectionCell.h"
#import "CCCollege.h"
#import "CCViewPositioningHelper.h"

static const NSInteger kMinCellHeight = 44;
static const NSInteger kDefaultTextLabelWidth = 293;
static const NSInteger kTextLabelOriginY = 10;
static const NSInteger kBottomSpace = 25;

@interface CCCollegeSelectionCell()

@property (nonatomic, strong) IBOutlet UILabel *collegeName;

@end


@implementation CCCollegeSelectionCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setSelectionColor];
}

- (void)prepareForReuse
{
    [CCViewPositioningHelper setWidth:kDefaultTextLabelWidth toView:self.collegeName];
}

- (void)setCellObject:(id)cellObject
{
    _cellObject = cellObject;
    self.collegeName.text = [(CCCollege *)cellObject name];
    [self.collegeName sizeToFit];
}

+ (CGFloat)heightForCellWithObject:(CCCollege *)college
{
    UIFont *font = [UIFont fontWithName:@"Avenir-Heavy" size:15];
    CGSize requiredSize = [college.name sizeWithFont:font constrainedToSize:CGSizeMake(kDefaultTextLabelWidth, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    return MAX(kMinCellHeight, requiredSize.height + kTextLabelOriginY + kBottomSpace);
}

@end