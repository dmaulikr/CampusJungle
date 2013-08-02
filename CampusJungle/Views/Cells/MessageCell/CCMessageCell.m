//
//  CCMessageCell.m
//  CampusJungle
//
//  Created by Vlad Korzun on 11.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCMessageCell.h"
#import "CCMessage.h"
#import "CCViewPositioningHelper.h"
#import "CCDateFormatterProtocol.h"
#import "CCButtonsHelper.h"
#import "CCUserSessionProtocol.h"

static const NSInteger kMinCellHeight = 90;
static const NSInteger kDefaultTextLabelWidth = 286;
static const NSInteger kTextLabelOriginY = 61;
static const NSInteger kBottomSpacing = 25;

@interface CCMessageCell()

@property (nonatomic, weak) IBOutlet UILabel *messageLabel;
@property (nonatomic, weak) IBOutlet UILabel *timeLabel;
@property (nonatomic, weak) IBOutlet UILabel *userName;
@property (nonatomic, weak) IBOutlet UIButton *deleteMessageButton;

@property (nonatomic, strong) CCMessage *message;
@property (nonatomic, strong) id<CCUserSessionProtocol> ioc_userSessionProvider;
@property (nonatomic, strong) id<CCDateFormatterProtocol> ioc_dateFormatterHelper;
@property (nonatomic, weak) id<CCMessageCellDelegate> delegate;

@end

@implementation CCMessageCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setSelectionColor];
    [self.deleteMessageButton addTarget:self action:@selector(deleteMessageButtonDidPressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)prepareForReuse
{
    [CCViewPositioningHelper setWidth:kDefaultTextLabelWidth toView:self.messageLabel];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [CCButtonsHelper removeBackgroundImageInButton:self.deleteMessageButton];
}

- (void)setCellObject:(CCMessage *)cellObject
{
    _cellObject = cellObject;
    self.message = cellObject;
    [self fillLabels];
    [self setupDeleteButtonVisibility];
}

- (void)fillLabels
{
    self.messageLabel.text = [self.message text];
    [self.messageLabel sizeToFit];
    
    self.timeLabel.text = [self.ioc_dateFormatterHelper formatedDateStringFromDate:[self.message createdAt]];
    self.userName.text = [NSString stringWithFormat:@"%@ %@", [self.message userFirstName], [self.message userLastName]];
}

- (void)setupDeleteButtonVisibility
{
    BOOL isHidden = YES;
    if ([self.ioc_userSessionProvider.currentUser.uid isEqualToString:self.message.senderID]) {
        isHidden = NO;
    }
    [self.deleteMessageButton setHidden:isHidden];
}

+ (CGFloat)heightForCellWithObject:(CCMessage *)message
{
    UIFont *font = [UIFont fontWithName:@"Avenir-MediumOblique" size:15];
    CGSize requiredSize = [message.text sizeWithFont:font constrainedToSize:CGSizeMake(kDefaultTextLabelWidth, font.lineHeight * 2) lineBreakMode:NSLineBreakByWordWrapping];
    return MAX(kMinCellHeight, requiredSize.height + kTextLabelOriginY + kBottomSpacing);
}

#pragma mark -
#pragma mark Actions
- (void)deleteMessageButtonDidPressed:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteMessage:)]) {
        [self.delegate deleteMessage:self.message];
    }
}

@end
