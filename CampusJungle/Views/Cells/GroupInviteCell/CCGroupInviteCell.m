//
//  CCGroupInviteCell.m
//  CampusJungle
//
//  Created by Yury Grinenko on 24.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCGroupInviteCell.h"
#import "CCGroupInvite.h"
#import "CCUserSessionProtocol.h"
#import "CCDateFormatterHelper.h"
#import "CCViewPositioningHelper.h"

static const NSInteger kMinCellHeight = 176;
static const NSInteger kTextlabelOriginY = 88;
static const NSInteger kDefaultTextLabelWidth = 245;
static const NSInteger kBottomSpace = 60;

@interface CCGroupInviteCell ()

@property (nonatomic, weak) IBOutlet UIView *inviteBodyView;
@property (nonatomic, weak) IBOutlet UILabel *inviteTextLabel;
@property (nonatomic, weak) IBOutlet UILabel *groupNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *userNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *updatedDateLabel;
@property (nonatomic, weak) IBOutlet UIImageView *leftArrowImageView;
@property (nonatomic, weak) IBOutlet UIImageView *rightArrowImageView;

@property (nonatomic, weak) IBOutlet UIView *senderButtonsView;
@property (nonatomic, weak) IBOutlet UIView *recepientButtonsView;

@property (nonatomic, strong) id<CCUserSessionProtocol> ioc_userSessionProvider;
@property (nonatomic, strong) id<CCDateFormatterProtocol> ioc_dateFormatterHelper;
@property (nonatomic, strong) CCGroupInvite *groupInvite;
@property (nonatomic, weak) id<CCGroupInviteCellDelegate> delegate;

@end

@implementation CCGroupInviteCell

- (void)prepareForReuse
{
    [super prepareForReuse];
    [CCViewPositioningHelper setWidth:kDefaultTextLabelWidth toView:self.inviteTextLabel];
}

- (void)setCellObject:(CCGroupInvite *)groupInvite
{
    self.groupInvite = groupInvite;
    [self fillLabels];
    [self fixLayout];
    [self setupMode];
}

- (void)fillLabels
{
    [self.userNameLabel setText:[NSString stringWithFormat:@"%@ %@", self.groupInvite.senderFirstName, self.groupInvite.senderLastName]];
    [self.updatedDateLabel setText:[self.ioc_dateFormatterHelper formatedDateStringFromDate:self.groupInvite.updatedDate]];
    [self.groupNameLabel setText:self.groupInvite.groupName];
    [self.inviteTextLabel setText:self.groupInvite.text];
    [self.inviteTextLabel sizeToFit];
}

- (void)fixLayout
{
    [CCViewPositioningHelper setHeight:[CCGroupInviteCell heightForCellWithObject:self.groupInvite] toView:self.inviteBodyView];
    [CCViewPositioningHelper setHeight:[CCViewPositioningHelper bottomOfView:self.inviteBodyView] toView:self];
    [CCViewPositioningHelper setCenterY:self.bounds.size.height / 2 toView:self.leftArrowImageView];
    [CCViewPositioningHelper setCenterY:self.bounds.size.height / 2 toView:self.rightArrowImageView];
}

- (void)setupMode
{
    BOOL isUserSender = [self.groupInvite.senderId isEqualToString:self.ioc_userSessionProvider.currentUser.uid];
    
    [self.leftArrowImageView setHidden:isUserSender];
    [self.rightArrowImageView setHidden:!isUserSender];
    
    [self.senderButtonsView setHidden:!isUserSender];
    [self.recepientButtonsView setHidden:isUserSender];
    
    CGFloat originX = isUserSender ? 10 : [CCViewPositioningHelper rightSideOfView:self.leftArrowImageView] + 10;
    [CCViewPositioningHelper setOriginX:originX toView:self.inviteBodyView];
}

+ (CGFloat)heightForCellWithObject:(CCGroupInvite *)groupInvite
{
    UIFont *font = [UIFont fontWithName:@"Avenir-Medium" size:17];
    CGSize requiredSize = [groupInvite.text sizeWithFont:font constrainedToSize:CGSizeMake(kDefaultTextLabelWidth, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    return MAX(kMinCellHeight, kTextlabelOriginY + requiredSize.height + kBottomSpace);
}

#pragma mark -
#pragma mark Actions
- (IBAction)acceptInviteButtonDidPressed:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(acceptGroupInvite:)]) {
        [self.delegate acceptGroupInvite:self.groupInvite];
    }
}

- (IBAction)rejectInviteButtonDidPressed:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(rejectGroupInvite:)]) {
        [self.delegate rejectGroupInvite:self.groupInvite];
    }
}

- (IBAction)resendInviteButtonDidPressed:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(resendGroupInvite:)]) {
        [self.delegate resendGroupInvite:self.groupInvite];
    }
}

- (IBAction)deleteButtonDidPressed:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteGroupInvite:)]) {
        [self.delegate deleteGroupInvite:self.groupInvite];
    }
}

@end
