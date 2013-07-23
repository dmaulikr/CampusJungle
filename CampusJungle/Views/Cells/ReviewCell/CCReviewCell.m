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
#import "CCDateFormatterProtocol.h"
#import "CCReview.h"

static const NSInteger kDefaultTextLabelWidth = 286;
static const NSInteger kMinCellHeight = 75;
static const NSInteger kTextLabelOriginY = 44;
static const NSInteger kBottomSpace = 10;

@interface CCReviewCell()

@property (nonatomic, weak) IBOutlet UILabel *reviewLabel;
@property (nonatomic, weak) IBOutlet UIView *rateContainer;
@property (nonatomic, weak) IBOutlet UILabel *createdDateLabel;
@property (nonatomic, strong) DYRateView *rateView;
@property (nonatomic, strong) id<CCDateFormatterProtocol> ioc_dateFormatterHelper;

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
    [self fillLabels];
    self.rateView.rate = [[(CCReview *)cellObject rank] integerValue];
}

- (void)fillLabels
{
    CCReview *review = (CCReview *)self.cellObject;
    self.reviewLabel.text = review.text;
    [self.reviewLabel sizeToFit];
    [self.createdDateLabel setText:[self.ioc_dateFormatterHelper formatedDateStringFromDate:review.createdDate]];
}

- (void)prepareForReuse
{
    [CCViewPositioningHelper setWidth:kDefaultTextLabelWidth toView:self.reviewLabel];
}

- (void)configStars
{
    self.rateView = [[DYRateView alloc] initWithFrame:self.rateContainer.bounds fullStar:[self scaledImageWithName:@"star_icon_active"] emptyStar:[self scaledImageWithName:@"star_icon"]];
    [self.rateContainer addSubview:self.rateView];
    self.rateView.alignment = RateViewAlignmentCenter;
}

- (UIImage *)scaledImageWithName:(NSString *)name
{
    UIImage *originalImage = [UIImage imageNamed:name];
    UIImage *scaledImage =
    [UIImage imageWithCGImage:[originalImage CGImage]
                        scale:(originalImage.scale * 2.0)
                  orientation:(originalImage.imageOrientation)];
    return scaledImage;
}

+ (CGFloat)heightForCellWithObject:(id)object
{
    CCReview *review = object;
    UIFont *font = [UIFont fontWithName:@"Avenir-Medium" size:15];
    CGSize requiredSize = [review.text sizeWithFont:font constrainedToSize:CGSizeMake(kDefaultTextLabelWidth, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    return MAX(kMinCellHeight, kTextLabelOriginY + requiredSize.height + kBottomSpace);
}

@end
