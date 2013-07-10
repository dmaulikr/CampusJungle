//
//  CCLocationCell.m
//  CampusJungle
//
//  Created by Yury Grinenko on 09.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCLocationCell.h"
#import "CCLocation.h"
#import "CCViewPositioningHelper.h"

static const NSInteger kDescriptionLabelDefaultWidth = 280;
static const NSInteger kDescriptionLabelOriginY = 30;
static const NSInteger kMinCellHeight = 60;

@interface CCLocationCell ()

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *descriptionLabel;

@end

@implementation CCLocationCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setSelectionColor];
}

- (void)prepareForReuse
{
    [CCViewPositioningHelper setWidth:kDescriptionLabelDefaultWidth toView:self.descriptionLabel];
}

- (void)setCellObject:(id)cellObject
{
    _cellObject = cellObject;
    [self fillLabels];
}

- (void)fillLabels
{
    [self.nameLabel setText:[self.cellObject name]];
    [self.descriptionLabel setText:[self.cellObject description]];
    [self.descriptionLabel sizeToFit];
}

+ (CGFloat)heightForCellWithLocation:(CCLocation *)location
{
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:13];
    CGSize requiredSize = [location.description sizeWithFont:font constrainedToSize:CGSizeMake(kDescriptionLabelDefaultWidth, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    return MAX(kMinCellHeight, kDescriptionLabelOriginY + requiredSize.height);
}

@end
