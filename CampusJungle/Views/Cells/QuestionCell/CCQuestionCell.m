//
//  CCQuestionCell.m
//  CampusJungle
//
//  Created by Yury Grinenko on 15.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCQuestionCell.h"
#import "CCQuestion.h"

#import "CCPluralizeHelper.h"
#import "CCViewPositioningHelper.h"
#import "CCUserSessionProtocol.h"
#import "MACircleProgressIndicator.h"

#import "CCDateFormatterProtocol.h"

static const NSInteger kTextLabelOriginY = 77;
static const NSInteger kDefaultTextLabelWidth = 272;
static const NSInteger kBottomSpace = 30;
static const NSInteger kAttachmentViewHeight = 34;
static const CGFloat kMinCellHeight = 133;

@interface CCQuestionCell ()<CCUploadIndicatorDelegateProtocol>

@property (nonatomic, weak) IBOutlet UIImageView *ownerAvatarImageView;
@property (nonatomic, weak) IBOutlet UILabel *ownerNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *createdAtLabel;
@property (nonatomic, weak) IBOutlet UILabel *questionTextLabel;
@property (nonatomic, weak) IBOutlet UILabel *answersNumberLabel;
@property (nonatomic, weak) IBOutlet UIButton *deleteQuestionButton;

@property (nonatomic, weak) IBOutlet UIView *attachmentView;
@property (nonatomic, weak) IBOutlet UIButton *emailAttachmentButton;
@property (nonatomic, weak) IBOutlet UIButton *viewAttachmentButton;

@property (nonatomic, strong) CCQuestion *question;
@property (nonatomic, weak) id<CCQuestionCellDelegate> delegate;
@property (nonatomic, strong) id<CCUserSessionProtocol> ioc_userSessionProvider;
@property (nonatomic, strong) id<CCDateFormatterProtocol> ioc_dateFormatterHelper;
@property (nonatomic, weak) IBOutlet MACircleProgressIndicator *indicator;

@end

@implementation CCQuestionCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setSelectionColor];
    [self.deleteQuestionButton addTarget:self action:@selector(deleteQuestionButtonDidPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.emailAttachmentButton addTarget:self action:@selector(emailAttachmentButtonDidPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.viewAttachmentButton addTarget:self action:@selector(viewAttachmentButtonDidPressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)prepareForReuse
{
    [CCViewPositioningHelper setWidth:kDefaultTextLabelWidth toView:self.questionTextLabel];
}

- (void)setCellObject:(CCQuestion *)object
{
    if(object.uploadProgress){
        [self setUpUploadingIndicatorWithObject:object];
    } else {
        [self removeIndicator];
    }
    _cellObject = object;
    self.question = object;
    [self fillLabels];
    [self fillImageView];
    [self setDeleteButtonVisibility];
    [self setAttachmentViewVisibility];
}

- (void)fillLabels
{
    [self.ownerNameLabel setText:[NSString stringWithFormat:@"%@ %@", self.question.ownerFirstName, self.question.ownerLastName]];
    [self.questionTextLabel setText:self.question.text];
    [self.createdAtLabel setText:[self.ioc_dateFormatterHelper formatedDateStringFromDate:self.question.createdDate]];
    
    [self.answersNumberLabel setText:[NSString stringWithFormat:@"%i %@", self.question.answersCount, [CCPluralizeHelper pluralizeEntityName:@"answer" withNumberOfItems:self.question.answersCount]]];
    
    [self.questionTextLabel sizeToFit];
    [CCViewPositioningHelper setOriginY:[CCViewPositioningHelper bottomOfView:self.questionTextLabel] toView:self.attachmentView];
    [CCViewPositioningHelper setOriginY:[CCViewPositioningHelper bottomOfView:self.attachmentView] + 5 toView:self.answersNumberLabel];
}

- (void)fillImageView
{
    NSURL *ownerAvatarUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",CCAPIDefines.baseURL, self.question.ownerAvatar]];
    [self.ownerAvatarImageView setImageWithURL:ownerAvatarUrl placeholderImage:[UIImage imageNamed:@"avatar_placeholder"]];
}

- (void)setDeleteButtonVisibility
{
    BOOL isHidden = YES;
    if ([self.ioc_userSessionProvider.currentUser.uid isEqualToString:self.question.ownerId]) {
        isHidden = NO;
    }
    [self.deleteQuestionButton setHidden:isHidden];
}

- (void)setAttachmentViewVisibility
{
    if ([self.question.attachment length] > 0 && ![self.question uploadProgress]) {
        [self.attachmentView setHidden:NO];
        [CCViewPositioningHelper setOriginY:[CCViewPositioningHelper bottomOfView:self.attachmentView] + 5 toView:self.answersNumberLabel];
    }
    else {
        [self.attachmentView setHidden:YES];
        [CCViewPositioningHelper setOriginY:self.attachmentView.frame.origin.y + 5 toView:self.answersNumberLabel];
    }
}

+ (CGFloat)heightForCellWithObject:(CCQuestion *)question
{
    UIFont *font = [UIFont fontWithName:@"Avenir-MediumOblique" size:15];
    CGSize requiredSize = [question.text sizeWithFont:font constrainedToSize:CGSizeMake(kDefaultTextLabelWidth, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    CGFloat additionalAttachmentHeight = [question.attachment length] > 0 ? kAttachmentViewHeight : 0;
    return MAX(kMinCellHeight + additionalAttachmentHeight, kTextLabelOriginY + requiredSize.height + kBottomSpace + additionalAttachmentHeight);
}

#pragma mark -
#pragma mark Actions
- (void)deleteQuestionButtonDidPressed:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteQuestion:)]) {
        [self.delegate deleteQuestion:self.question];
    }
}


- (void)emailAttachmentButtonDidPressed:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(emailAttachmentOfQuestion:)]) {
        [self.delegate emailAttachmentOfQuestion:self.question];
    }
}

- (void)viewAttachmentButtonDidPressed:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(viewAttachmentOfQuestion:)]) {
        [self.delegate viewAttachmentOfQuestion:self.question];
    }
}

- (void)setUpUploadingIndicatorWithObject:(CCQuestion *)object
{
    self.indicator.color = [UIColor brownColor];
    if(_cellObject.uploadProgress){
        [(CCQuestion *)_cellObject setDelegate:nil];
    }
    object.delegate = self;
    self.indicator.value = object.uploadProgress.floatValue;
    self.indicator.hidden = NO;
    self.deleteQuestionButton.hidden = YES;
}

- (void)uploadProgressDidUpdate
{
    self.indicator.value = [(CCQuestion *)self.cellObject uploadProgress].floatValue;
}

- (void)removeIndicator
{
    self.indicator.hidden = YES;
    self.deleteQuestionButton.hidden = NO;
    [self setAttachmentViewVisibility];
}

@end
