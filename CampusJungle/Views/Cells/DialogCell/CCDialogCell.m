//
//  CCMessageCell.m
//  CampusJungle
//
//  Created by Vlad Korzun on 11.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCDialogCell.h"
#import "CCMessage.h"
#import "CCViewPositioningHelper.h"
#import "CCDateFormatterProtocol.h"
#import "CCButtonsHelper.h"
#import "CCUserSessionProtocol.h"


static const NSInteger kMinCellHeight = 90;
static const NSInteger kDefaultTextLabelWidth = 239;
static const NSInteger kTextLabelOriginY = 61;
static const NSInteger kBottomSpacing = 25;

@interface CCDialogCell()

@property (nonatomic, weak) IBOutlet UILabel *messageLabel;
@property (nonatomic, weak) IBOutlet UILabel *timeLabel;
@property (nonatomic, weak) IBOutlet UILabel *userName;
@property (nonatomic, weak) IBOutlet UIButton *deleteMessageButton;
@property (nonatomic, weak) IBOutlet UIImageView *avatar;

@property (nonatomic, strong) CCDialog *dialog;
@property (nonatomic, strong) id<CCUserSessionProtocol> ioc_userSessionProvider;
@property (nonatomic, strong) id<CCDateFormatterProtocol> ioc_dateFormatterHelper;
@property (nonatomic, weak) id<CCDialogCellDelegate> delegate;

@end

@implementation CCDialogCell

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

- (void)setCellObject:(CCDialog *)cellObject
{
    _cellObject = cellObject;
    self.dialog = cellObject;
    [self fillLabels];
    [self setupDeleteButtonVisibility];
}

- (void)fillLabels
{
    self.messageLabel.text = [self.dialog.lastMessage text];
    [self.messageLabel sizeToFit];
    
    self.timeLabel.text = [self.ioc_dateFormatterHelper formatedDateStringFromDate:[self.dialog.lastMessage createdAt]];
    self.userName.text = [NSString stringWithFormat:@"%@ %@", [self.dialog.interlocutor firstName], [self.dialog.interlocutor lastName]];
    NSString *avatarAddress = [NSString stringWithFormat:@"%@%@",CCAPIDefines.baseURL,self.dialog.lastMessage.userAvatar];
    [self.avatar setImageWithURL:[NSURL URLWithString:avatarAddress] placeholderImage:[UIImage imageNamed:@"avatar_placeholder"]];
    
}

- (void)setupDeleteButtonVisibility
{

    [self.deleteMessageButton setHidden:NO];
}

+ (CGFloat)heightForCellWithObject:(CCDialog *)dialog
{
    UIFont *font = [UIFont fontWithName:@"Avenir-MediumOblique" size:15];
    CGSize requiredSize = [dialog.lastMessage.text sizeWithFont:font constrainedToSize:CGSizeMake(kDefaultTextLabelWidth, font.lineHeight * 2) lineBreakMode:NSLineBreakByWordWrapping];
    return MAX(kMinCellHeight, requiredSize.height + kTextLabelOriginY + kBottomSpacing);
}

#pragma mark -
#pragma mark Actions
- (void)deleteMessageButtonDidPressed:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteMessage:)]) {
        [self.delegate deleteDialog:self.dialog];
    }
}

@end
