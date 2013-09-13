//
//  CCAnswerCell.m
//  CampusJungle
//
//  Created by Yury Grinenko on 16.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAnswerCell.h"
#import "CCAnswer.h"

#import "CCUserSessionProtocol.h"
#import "CCViewPositioningHelper.h"
#import "CCDateFormatterProtocol.h"

static const NSInteger kTextLabelOriginY = 55;
static const NSInteger kDefaultTextLabelWidth = 286;
static const NSInteger kBottomSpace = 35;
static const CGFloat kMinCellHeight = 113;

@interface CCAnswerCell ()

@property (nonatomic, weak) IBOutlet UILabel *answerTextLabel;
@property (nonatomic, weak) IBOutlet UILabel *userNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *createdDateLabel;
@property (nonatomic, weak) IBOutlet UIButton *deleteAnswerButton;
@property (nonatomic, weak) IBOutlet UILabel *likesNumberLabel;
@property (nonatomic, weak) IBOutlet UIButton *likeButton;
@property (nonatomic, weak) IBOutlet UILabel *commentsCountLabel;
@property (nonatomic, weak) IBOutlet UIButton *emailAttachmentButton;
@property (nonatomic, weak) IBOutlet UIButton *viewAttachmentButton;
@property (nonatomic, weak) IBOutlet UIImageView *cellBG;

@property (nonatomic, strong) id<CCUserSessionProtocol> ioc_userSessionProvider;
@property (nonatomic, strong) id<CCDateFormatterProtocol> ioc_dateFormatterHelper;
@property (nonatomic, strong) CCAnswer *answer;
@property (nonatomic, weak) id<CCAnswerCellDelegate> delegate;

@end

@implementation CCAnswerCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setSelectionColor];
    
    [self.deleteAnswerButton addTarget:self action:@selector(deleteAnswerButtonDidPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.likeButton addTarget:self action:@selector(likeAnswerButtonDidPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.emailAttachmentButton addTarget:self action:@selector(emailAttachmentButtonDidPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.viewAttachmentButton addTarget:self action:@selector(viewAttachmentButtonDidPressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)emailAttachmentButtonDidPressed:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(emailAttachmentOfAnswer:)]) {
        [self.delegate emailAttachmentOfAnswer:self.answer];
    }
}

- (void)viewAttachmentButtonDidPressed:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(viewAttachmentOfAnswer:)]) {
        [self.delegate viewAttachmentOfAnswer:self.answer];
    }
}

- (void)setIsEven:(BOOL)isEven
{
    _isEven = isEven;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [CCButtonsHelper removeBackgroundImageInButton:self.deleteAnswerButton];
    [CCButtonsHelper removeBackgroundImageInButton:self.likeButton];
    [CCButtonsHelper removeBackgroundImageInButton:self.emailAttachmentButton];
    [CCButtonsHelper removeBackgroundImageInButton:self.viewAttachmentButton];
}

- (void)prepareForReuse
{
    [CCViewPositioningHelper setWidth:kDefaultTextLabelWidth toView:self.answerTextLabel];
}

- (void)setCellObject:(CCAnswer *)answer
{
    _cellObject = answer;
    self.answer = answer;
    [self fillLabels];
    [self setupLikeButton];
    [self setDeleteButtonVisibility];
    [self setAttachmentButtonsVisibility];
}

- (void)setAttachmentButtonsVisibility
{
    if(self.answer.attachment.length){
        self.emailAttachmentButton.hidden = NO;
        self.viewAttachmentButton.hidden = NO;
    } else {
        self.emailAttachmentButton.hidden = YES;
        self.viewAttachmentButton.hidden = YES;
    }
}

- (void)addBottomDivider
{
    self.bottomDivider = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 1, self.bounds.size.width - 2 * 0, 1)];
    [self.bottomDivider setBackgroundColor:BASE_DIVIDER_COLOR];
    [self.bottomDivider setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin];
    [self addSubview:self.bottomDivider];
}

- (void)fillLabels
{
    self.cellBG.hidden = self.isEven;
    [self.userNameLabel setText:[NSString stringWithFormat:@"%@ %@", self.answer.ownerFirstName, self.answer.ownerLastName]];
    [self.createdDateLabel setText:[self.ioc_dateFormatterHelper formatedDateStringFromDate:self.answer.createdDate]];
    [self.answerTextLabel setText:self.answer.text];
    [self.answerTextLabel sizeToFit];
    
    [self.likesNumberLabel setText:[NSString stringWithFormat:@"%i", self.answer.likesCount]];
    [self.commentsCountLabel setText:[NSString stringWithFormat:@"%i comments", self.answer.commentsCount]];
}

- (void)setupLikeButton
{
    self.likeButton.selected = self.answer.isLiked;
}

- (void)setDeleteButtonVisibility
{
    BOOL isHidden = YES;
    if ([self.ioc_userSessionProvider.currentUser.uid isEqualToString:self.answer.ownerId]) {
        isHidden = NO;
    }
    [self.reportButtonContainer setHidden:!isHidden];
    [self.deleteAnswerButton setHidden:isHidden];
}

+ (CGFloat)heightForCellWithObject:(CCAnswer *)answer
{
    float attachmentHeight = 0;
    if(answer.attachment.length) {
        attachmentHeight = 40;
    }
    UIFont *font = [UIFont fontWithName:@"Avenir-MediumOblique" size:15];
    CGSize requiredSize = [answer.text sizeWithFont:font constrainedToSize:CGSizeMake(kDefaultTextLabelWidth, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    return MAX(kMinCellHeight + attachmentHeight, kTextLabelOriginY+ attachmentHeight + requiredSize.height + kBottomSpace);
}

- (void)invertAnswerLikeStatus
{
    self.answer.isLiked = !self.answer.isLiked;
    if (self.answer.isLiked) {
        self.answer.likesCount++;
    }
    else {
        self.answer.likesCount--;
    }
    [self.likesNumberLabel setText:[NSString stringWithFormat:@"%i", self.answer.likesCount]];
    [self setupLikeButton];
}

#pragma mark -
#pragma mark Actions
- (void)deleteAnswerButtonDidPressed:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteAnswer:)]) {
        [self.delegate deleteAnswer:self.answer];
    }
}

- (void)likeAnswerButtonDidPressed:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(likeAnswer:successBlock:)]) {
        [self.delegate likeAnswer:self.answer successBlock:^{
            [self invertAnswerLikeStatus];
        }];
    }
}

@end
