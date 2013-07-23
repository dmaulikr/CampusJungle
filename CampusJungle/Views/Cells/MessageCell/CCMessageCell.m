//
//  CCMessageCell.m
//  CampusJungle
//
//  Created by Vlad Korzun on 11.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCMessageCell.h"
#import "CCViewPositioningHelper.h"
#import "CCDateFormatterProtocol.h"

static const NSInteger kMinCellHeight = 90;
static const NSInteger kDefaultTextLabelWidth = 286;
static const NSInteger kTextLabelOriginY = 61;
static const NSInteger kBottomSpacing = 5;

@interface CCMessageCell()

@property (nonatomic, weak) IBOutlet UILabel *messageLabel;
@property (nonatomic, weak) IBOutlet UILabel *timeLabel;
@property (nonatomic, weak) IBOutlet UILabel *userName;

@property (nonatomic, strong) id<CCDateFormatterProtocol> ioc_dateFormatterHelper;

@end

@implementation CCMessageCell

- (void)setCellObject:(CCMessage *)cellObject
{
    _cellObject = cellObject;
    
    self.messageLabel.text = [cellObject text];
    [self.messageLabel sizeToFit];
    
    self.timeLabel.text = [self.ioc_dateFormatterHelper formatedDateStringFromDate:[cellObject createdAt]];
    self.userName.text = [NSString stringWithFormat:@"%@ %@", [cellObject userFirstName], [cellObject userLastName]];
    [self setSelectionColor];
}

- (void)prepareForReuse
{
    [CCViewPositioningHelper setWidth:kDefaultTextLabelWidth toView:self.messageLabel];
}

+ (CGFloat)heightForCellWithObject:(CCMessage *)message
{
    UIFont *font = [UIFont fontWithName:@"Avenir-MediumOblique" size:15];
    CGSize requiredSize = [message.text sizeWithFont:font constrainedToSize:CGSizeMake(kDefaultTextLabelWidth, font.lineHeight * 2) lineBreakMode:NSLineBreakByWordWrapping];
    return MAX(kMinCellHeight, requiredSize.height + kTextLabelOriginY + kBottomSpacing);
}

@end
