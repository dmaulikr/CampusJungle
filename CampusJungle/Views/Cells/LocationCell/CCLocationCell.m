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

#import "CCUserSessionProtocol.h"

static const NSInteger kDescriptionLabelDefaultWidth = 250;
static const NSInteger kDescriptionLabelOriginY = 51;
static const NSInteger kMinCellHeight = 85;

@interface CCLocationCell ()

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, weak) IBOutlet UILabel *addressLabel;
@property (nonatomic, weak) IBOutlet UIButton *deleteLocationButton;

@property (nonatomic, strong) id<CCUserSessionProtocol> ioc_userSession;
@property (nonatomic, weak) id<CCLocationCellDelegate> delegate;

@end

@implementation CCLocationCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setSelectionColor];
    [self.deleteLocationButton addTarget:self action:@selector(deleteLocationButtonDidPressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)prepareForReuse
{
    [CCViewPositioningHelper setWidth:kDescriptionLabelDefaultWidth toView:self.descriptionLabel];
}

- (void)setCellObject:(id)cellObject
{
    _cellObject = cellObject;
    [self fillLabels];
    [self setupDeleteButtonVisibility];
}

- (void)fillLabels
{
    [self.nameLabel setText:[self.cellObject name]];
    [self.descriptionLabel setText:[self.cellObject description]];
    [self.addressLabel setText:[self.cellObject address]];
    [self.descriptionLabel sizeToFit];
}

- (void)setupDeleteButtonVisibility
{
    BOOL isHidden = YES;
    if ([self.ioc_userSession.currentUser.uid isEqualToString:self.cellObject.ownerId]) {
        isHidden = NO;
    }
    [self.deleteLocationButton setHidden:isHidden];
}

+ (CGFloat)heightForCellWithObject:(id)object
{
    CCLocation *location = object;
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:13];
    CGSize requiredSize = [location.description sizeWithFont:font constrainedToSize:CGSizeMake(kDescriptionLabelDefaultWidth, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    return MAX(kMinCellHeight, kDescriptionLabelOriginY + requiredSize.height);
}

#pragma mark -
#pragma mark Actions
- (void)deleteLocationButtonDidPressed:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteLocation:)]) {
        [self.delegate deleteLocation:self.cellObject];
    }
}


@end
