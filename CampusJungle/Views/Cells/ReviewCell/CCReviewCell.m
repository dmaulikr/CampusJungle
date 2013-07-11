//
//  CCReviewCell.m
//  CampusJungle
//
//  Created by Vlad Korzun on 11.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCReviewCell.h"
#import "DYRateView.h"
#import "CCViewPositioningHelper.h"
#import "CCReview.h"

@interface CCReviewCell()

@property (nonatomic, weak) IBOutlet UILabel *reviewLabel;
@property (nonatomic, weak) IBOutlet UIView *rateContainer;
@property (nonatomic, strong) DYRateView *rateView;

@end

@implementation CCReviewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if([super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self configStars];
    }
    return self;
}

- (void)setCellObject:(id)cellObject
{
    _cellObject = cellObject;
    self.rateView.rate = [[(CCReview *)cellObject rank] integerValue];
    self.reviewLabel.text = [(CCReview *)cellObject text];
    [self.reviewLabel sizeToFit];
    [CCViewPositioningHelper setOriginX:5 toView:self.reviewLabel];
}

- (void)prepareForReuse
{
    [CCViewPositioningHelper setWidth:300 toView:self.reviewLabel];
    [CCViewPositioningHelper setOriginX:10 toView:self.reviewLabel];
}

- (void)configStars
{
    self.rateView = [[DYRateView alloc] initWithFrame:self.rateContainer.bounds fullStar:[UIImage imageNamed:@"StarFullLarge"] emptyStar:[UIImage imageNamed:@"StarEmptyLarge"]];
    [self.rateContainer addSubview:self.rateView];
    self.rateView.alignment = RateViewAlignmentCenter;
}

+ (CGFloat)heightForCellWithObject:(id)object
{
    CCReview *review = object;
    UIFont *font = [UIFont boldSystemFontOfSize:17];
    CGSize requiredSize = [review.text sizeWithFont:font constrainedToSize:CGSizeMake(300, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    
    return MAX(60, requiredSize.height + 40);
}

@end
