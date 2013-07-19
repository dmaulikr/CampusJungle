//
//  CCCommentCell.m
//  CampusJungle
//
//  Created by Yury Grinenko on 17.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCCommentCell.h"
#import "CCComment.h"
#import "CCUserSessionProtocol.h"
#import "CCViewPositioningHelper.h"
#import "CCDateFormatterProtocol.h"

static const NSInteger kTextLabelOriginY = 55;
static const NSInteger kDefaultTextLabelWidth = 286;
static const NSInteger kBottomSpace = 5;
static const CGFloat kMinCellHeight = 90;

@interface CCCommentCell ()

@property (nonatomic, weak) IBOutlet UILabel *commentTextLabel;
@property (nonatomic, weak) IBOutlet UILabel *userNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *createdDateLabel;
@property (nonatomic, weak) IBOutlet UIButton *deleteCommentButton;

@property (nonatomic, weak) id<CCCommentCellDelegate> delegate;
@property (nonatomic, strong) id<CCUserSessionProtocol> ioc_userSessionProvider;
@property (nonatomic, strong) id<CCDateFormatterProtocol> ioc_dateFormatterHelper;
@property (nonatomic, strong) CCComment *comment;

@end

@implementation CCCommentCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self.deleteCommentButton addTarget:self action:@selector(deleteCommentButtonDidPressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)layoutSubviews
{
    [CCButtonsHelper removeBackgroundImageInButton:self.deleteCommentButton];
}

- (void)prepareForReuse
{
    [CCViewPositioningHelper setWidth:kDefaultTextLabelWidth toView:self.commentTextLabel];
}

- (void)setCellObject:(CCComment *)comment
{
    self.comment = comment;
    [self fillLabels];
    [self setDeleteButtonVisibility];
}

- (void)fillLabels
{
    [self.userNameLabel setText:[NSString stringWithFormat:@"%@ %@", self.comment.ownerFirstName, self.comment.ownerLastName]];
    [self.createdDateLabel setText:[self.ioc_dateFormatterHelper formatedDateStringFromDate:self.comment.createdDate]];
    [self.commentTextLabel setText:self.comment.text];
    [self.commentTextLabel sizeToFit];
}

- (void)setDeleteButtonVisibility
{
    BOOL isHidden = YES;
    if ([self.ioc_userSessionProvider.currentUser.uid isEqualToString:self.comment.ownerId]) {
        isHidden = NO;
    }
    [self.deleteCommentButton setHidden:isHidden];
}

+ (CGFloat)heightForCellWithObject:(CCComment *)comment
{
    UIFont *font = [UIFont fontWithName:@"Avenir-MediumOblique" size:15];
    CGSize requiredSize = [comment.text sizeWithFont:font constrainedToSize:CGSizeMake(kDefaultTextLabelWidth, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    return MAX(kMinCellHeight, kTextLabelOriginY + requiredSize.height + kBottomSpace);
}

#pragma mark -
#pragma mark Actions
- (void)deleteCommentButtonDidPressed:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteComment:)]) {
        [self.delegate deleteComment:self.comment];
    }
}

@end
