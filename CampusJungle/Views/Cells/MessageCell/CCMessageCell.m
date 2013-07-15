//
//  CCMessageCell.m
//  CampusJungle
//
//  Created by Vlad Korzun on 11.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCMessageCell.h"
#import "CCViewPositioningHelper.h"

@interface CCMessageCell()

@property (nonatomic, weak) IBOutlet UILabel *messageLabel;
@property (nonatomic, weak) IBOutlet UILabel *timeLabel;
@property (nonatomic, weak) IBOutlet UILabel *userName;

@end

@implementation CCMessageCell

- (void)setCellObject:(id)cellObject
{
    _cellObject = cellObject;
    
    self.messageLabel.text = [(CCMessage *)cellObject text];
    [self.messageLabel sizeToFit];
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale systemLocale]];
    [outputFormatter setDateFormat:@"hh:mma dd/MM/yy"];
    
    self.timeLabel.text = [outputFormatter stringFromDate:[(CCMessage *)cellObject createdAt]];
    self.userName.text = [NSString stringWithFormat:@"%@ %@", [(CCMessage *)cellObject userFirstName],[(CCMessage *)cellObject userLastName]];
    [CCViewPositioningHelper setOriginX:5 toView:self.messageLabel];
    [self setSelectionColor];
}

- (void)prepareForReuse
{
    [CCViewPositioningHelper setWidth:300 toView:self.messageLabel];
    [CCViewPositioningHelper setOriginX:10 toView:self.messageLabel];
}

+ (CGFloat)heightForCellWithObject:(id)object
{
    CCMessage *review = object;
    UIFont *font = [UIFont systemFontOfSize:17];
    CGSize requiredSize = [review.text sizeWithFont:font constrainedToSize:CGSizeMake(300, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    
    return MAX(44, requiredSize.height + 50);
}

@end
