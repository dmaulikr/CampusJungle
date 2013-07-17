//
//  CCOfferCell.m
//  CampusJungle
//
//  Created by Vlad Korzun on 12.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCOfferCell.h"
#import "CCOffer.h"
#import "CCViewPositioningHelper.h"
#import "CCDateFormatterProtocol.h"

@interface CCOfferCell()

@property (nonatomic, weak) IBOutlet UILabel *messageLabel;
@property (nonatomic, weak) IBOutlet UILabel *timeLabel;
@property (nonatomic, weak) IBOutlet UILabel *userName;

@property (nonatomic, strong) id<CCDateFormatterProtocol> ioc_dateFormatterHelper;

@end

@implementation CCOfferCell

- (void)setCellObject:(id)cellObject
{
    _cellObject = cellObject;
    
    self.messageLabel.text = [(CCOffer *)cellObject text];
    [self.messageLabel sizeToFit];
    
    self.timeLabel.text = [self.ioc_dateFormatterHelper formatedDateStringFromDate:[(CCOffer *)cellObject createdAt]];
    self.userName.text = [NSString stringWithFormat:@"%@ %@",[(CCOffer *)cellObject userFirstName],[(CCOffer *)cellObject userLastName]];
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
    CCOffer *review = object;
    UIFont *font = [UIFont systemFontOfSize:17];
    CGSize requiredSize = [review.text sizeWithFont:font constrainedToSize:CGSizeMake(300, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    
    return MAX(44, requiredSize.height + 50);
}


@end
