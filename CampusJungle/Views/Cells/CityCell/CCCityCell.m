//
//  CCCityCell.m
//  CampusJungle
//
//  Created by Vlad Korzun on 29.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCCityCell.h"
#import "CCCity.h"
#import "CCViewPositioningHelper.h"

static const NSInteger kMinCellHeight = 44;
static const NSInteger kDefaultTextLabelWidth = 293;
static const NSInteger kTextLabelOriginY = 10;
static const NSInteger kBottomSpace = 5;

@interface CCCityCell()

@property (nonatomic, weak) IBOutlet UILabel *cityNameLabel;

@end

@implementation CCCityCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setSelectionColor];
}

- (void)prepareForReuse
{
    [CCViewPositioningHelper setWidth:kDefaultTextLabelWidth toView:self.cityNameLabel];
}

- (void)setCellObject:(id)cellObject
{
    _cellObject = cellObject;
    self.cityNameLabel.text = [(CCCity *)cellObject name];
}

+ (CGFloat)heightForCellWithObject:(CCCity *)city
{
    UIFont *font = [UIFont fontWithName:@"Avenir-Heavy" size:15];
    CGSize requiredSize = [city.name sizeWithFont:font constrainedToSize:CGSizeMake(kDefaultTextLabelWidth, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    return MAX(kMinCellHeight, requiredSize.height + kTextLabelOriginY + kBottomSpace);
}

@end
