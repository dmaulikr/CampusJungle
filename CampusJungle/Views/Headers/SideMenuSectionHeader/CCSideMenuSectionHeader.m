//
//  CCSideMenuSectionHeader.m
//  CampusJungle
//
//  Created by Yury Grinenko on 03.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCSideMenuSectionHeader.h"
#import "CCViewPositioningHelper.h"
#import "CCSideMenuDataSource.h"
#import "CCButtonsHelper.h"

static const NSInteger kDefaultTextLabelWidth = 155;
static const NSInteger kMinCellHeight = 44;

@interface CCSideMenuSectionHeader ()

@property (nonatomic, weak) IBOutlet UILabel *textLabel;
@property (nonatomic, weak) IBOutlet UIImageView *backgroundImageView;
@property (nonatomic, weak) IBOutlet UIButton *addClassesButton;
@property (nonatomic, weak) id<CCSideMenuDelegate> delegate;
@property (nonatomic, strong) NSString *collegeId;

@end

@implementation CCSideMenuSectionHeader

- (id)initWithText:(NSString *)text collegeId:(NSString *)collegeId delegate:(id<CCSideMenuDelegate>)delegate
{
    self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil][0];
    if (self) {
        [self setupButtons];
        [self setDelegate:delegate];
        [self setCollegeId:collegeId];
        [self setText:text];
        [self setCorrectHeight];
        [self setBackgroundImage];
    }
    return self;
}

- (void)setupButtons
{
    [CCButtonsHelper removeBackgroundImageInButton:self.addClassesButton];
}

- (void)setText:(NSString *)text
{
    [self.textLabel setText:[text uppercaseString]];
    [self.textLabel sizeToFit];
}

- (void)setBackgroundImage
{
    UIImage *image = [self.backgroundImageView image];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(22, 0, 21, 0)];
    [self.backgroundImageView setImage:image];
}

- (void)setCorrectHeight
{
    CGFloat selfHeight = [CCSideMenuSectionHeader heightForHeaderWithText:self.textLabel.text];
    [CCViewPositioningHelper setHeight:selfHeight toView:self];
    [CCViewPositioningHelper setHeight:selfHeight toView:self.textLabel];
}

+ (CGFloat)heightForHeaderWithText:(NSString *)text;
{
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:13];
    CGSize size = [[text uppercaseString] sizeWithFont:font constrainedToSize:CGSizeMake(kDefaultTextLabelWidth, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    return MAX(size.height + 10, kMinCellHeight);
}

#pragma mark -
#pragma mark Actions
- (IBAction)addClassButtonDidPressed:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(addClassToCollegeWithId:)]) {
        [self.delegate addClassToCollegeWithId:self.collegeId];
    }
}


@end
