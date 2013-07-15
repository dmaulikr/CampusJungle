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

static const NSInteger kTextLabelOriginY = 77;
static const NSInteger kDefaultTextLabelWidth = 272;
static const NSInteger kBottomSpace = 30;
static const CGFloat kMinCellHeight = 133;

@interface CCQuestionCell ()

@property (nonatomic, weak) IBOutlet UIImageView *ownerAvatarImageView;
@property (nonatomic, weak) IBOutlet UILabel *ownerNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *createdAtLabel;
@property (nonatomic, weak) IBOutlet UILabel *questionTextLabel;
@property (nonatomic, weak) IBOutlet UILabel *answersNumberLabel;
@property (nonatomic, weak) IBOutlet UIButton *deleteQuestionButton;

@property (nonatomic, strong) CCQuestion *question;
@property (nonatomic, weak) id<CCQuestionCellDelegate> delegate;
@property (nonatomic, strong) id<CCUserSessionProtocol> ioc_userSessionProvider;

@end

@implementation CCQuestionCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setSelectionColor];
    [self.deleteQuestionButton addTarget:self action:@selector(deleteQuestionButtonDidPressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)prepareForReuse
{
    [CCViewPositioningHelper setWidth:kDefaultTextLabelWidth toView:self.questionTextLabel];
}

- (void)setCellObject:(CCQuestion *)object
{
    self.question = object;
    [self fillLabels];
    [self fillImageView];
    [self setDeleteButtonVisibility];
}

- (void)fillLabels
{
    [self.ownerNameLabel setText:[NSString stringWithFormat:@"%@ %@", self.question.ownerFirstName, self.question.ownerLastName]];
    [self.questionTextLabel setText:self.question.text];
    [self.createdAtLabel setText:[NSString stringWithFormat:@"%@", self.question.createdDate]];
    [self.answersNumberLabel setText:[NSString stringWithFormat:@"%i %@", self.question.answersCount, [CCPluralizeHelper pluralizeEntityName:@"answer" withNumberOfItems:self.question.answersCount]]];
    
    [self.questionTextLabel sizeToFit];
    [CCViewPositioningHelper setOriginY:[CCViewPositioningHelper bottomOfView:self.questionTextLabel] + 5 toView:self.answersNumberLabel];
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

+ (CGFloat)heightForCellWithObject:(CCQuestion *)question
{
    UIFont *font = [UIFont fontWithName:@"Avenir-Medium" size:15];
    CGSize requiredSize = [question.text sizeWithFont:font constrainedToSize:CGSizeMake(kDefaultTextLabelWidth, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    return MAX(kMinCellHeight, kTextLabelOriginY + requiredSize.height + kBottomSpace);
}

#pragma mark -
#pragma mark Actions
- (void)deleteQuestionButtonDidPressed:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteQuestion:)]) {
        [self.delegate deleteQuestion:self.question];
    }
}

@end
