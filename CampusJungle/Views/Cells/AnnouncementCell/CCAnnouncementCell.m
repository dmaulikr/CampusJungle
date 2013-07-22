//
//  CCAnoucementCell.m
//  CampusJungle
//
//  Created by Vlad Korzun on 23.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAnnouncementCell.h"
#import "CCDateFormatterProtocol.h"
#import "CCUserSessionProtocol.h"
#import "CCViewPositioningHelper.h"


static const NSInteger kTextLabelOriginY = 80;
static const NSInteger kDefaultTextLabelWidth = 286;
static const NSInteger kBottomSpace = 15;
static const CGFloat kMinCellHeight = 118;

@interface CCAnnouncementCell ()

@property (nonatomic, weak) IBOutlet UILabel *answerTextLabel;
@property (nonatomic, weak) IBOutlet UILabel *userNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *createdDateLabel;
@property (nonatomic, weak) IBOutlet UIButton *deleteAnswerButton;
@property (nonatomic, weak) IBOutlet UILabel *topicLabel;

@property (nonatomic, strong) id<CCUserSessionProtocol> ioc_userSessionProvider;
@property (nonatomic, strong) id<CCDateFormatterProtocol> ioc_dateFormatterHelper;
@property (nonatomic, strong) CCAnnouncement *announcement;
@property (nonatomic, weak) id<CCAnnouncementCellDelegate> delegate;

@end


@implementation CCAnnouncementCell

- (void)setCellObject:(CCAnnouncement *)announcement
{
    self.announcement = announcement;
    [self fillLabels];
    [self setDeleteButtonVisibility];
}

- (void)setDeleteButtonVisibility
{
    BOOL isHidden = YES;
    if ([self.ioc_userSessionProvider.currentUser.uid isEqualToString:self.announcement.ownerId]) {
        isHidden = NO;
    }
    [self.deleteAnswerButton setHidden:isHidden];
}

+ (CGFloat)heightForCellWithObject:(CCAnnouncement *)announcement
{
    UIFont *font = [UIFont fontWithName:@"Avenir-MediumOblique" size:15];
    CGSize requiredSize = [announcement.message sizeWithFont:font constrainedToSize:CGSizeMake(kDefaultTextLabelWidth, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    return MAX(kMinCellHeight, kTextLabelOriginY + requiredSize.height + kBottomSpace);
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setSelectionColor];
    [self addBottomDivider];
    [self.deleteAnswerButton addTarget:self action:@selector(deleteAnnouncementButtonDidPressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)deleteAnnouncementButtonDidPressed:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteAnnouncement:)]) {
        [self.delegate deleteAnnouncement:self.announcement];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [CCButtonsHelper removeBackgroundImageInButton:self.deleteAnswerButton];
}

- (void)prepareForReuse
{
    [CCViewPositioningHelper setWidth:kDefaultTextLabelWidth toView:self.answerTextLabel];
}

- (void)fillLabels
{
    [self.userNameLabel setText:[NSString stringWithFormat:@"%@ %@", self.announcement.ownerFirstName, self.announcement.ownerLastName]];
    [self.createdDateLabel setText:[self.ioc_dateFormatterHelper formatedDateStringFromDate:self.announcement.createdDate]];
    self.topicLabel.text = self.announcement.topic;
    [self.answerTextLabel setText:self.announcement.message];
    [self.answerTextLabel sizeToFit];
}



@end
