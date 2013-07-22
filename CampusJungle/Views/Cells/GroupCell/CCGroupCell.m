//
//  CCGroupCell.m
//  CampusJungle
//
//  Created by Yury Grinenko on 12.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCGroupCell.h"
#import "CCGroup.h"
#import "CCButtonsHelper.h"
#import "CCUserSessionProtocol.h"

static const NSInteger kCellHeight = 112;

@interface CCGroupCell ()

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *ownerNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *membersCountLabel;
@property (nonatomic, weak) IBOutlet UIImageView *groupImageView;
@property (nonatomic, weak) IBOutlet UIButton *deleteGroupButton;

@property (nonatomic, weak) id<CCGroupCellDelegate> delegate;
@property (nonatomic, strong) id<CCUserSessionProtocol> ioc_userSessionProvider;

@end

@implementation CCGroupCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setSelectionColor];
    [self.deleteGroupButton addTarget:self action:@selector(deleteGroupButtonDidPressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [CCButtonsHelper removeBackgroundImageInButton:self.deleteGroupButton];
}

- (void)setCellObject:(id)cellObject
{
    _cellObject = cellObject;
    [self fillLabels];
    [self fillImageView];
    [self setDeleteButtonVisibility];
}

- (void)fillLabels
{
    [self.nameLabel setText:self.cellObject.name];
    [self.ownerNameLabel setText:[NSString stringWithFormat:@"Owner: %@ %@", self.cellObject.ownerFirstName, self.cellObject.ownerLastName]];
    [self.membersCountLabel setText:[NSString stringWithFormat:@"%i members", self.cellObject.membersCount]];
}

- (void)fillImageView
{
    NSURL *groupImageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",CCAPIDefines.baseURL, self.cellObject.image]];
    [self.groupImageView setImageWithURL:groupImageUrl placeholderImage:[UIImage imageNamed:@"avatar_placeholder"]];
}

- (void)setDeleteButtonVisibility
{
    BOOL isHidden = YES;
    if ([self.cellObject.ownerId isEqualToString:self.ioc_userSessionProvider.currentUser.uid]) {
        isHidden = NO;
    }
    [self.deleteGroupButton setHidden:isHidden];
}

+ (CGFloat)heightForCellWithObject:(id)object
{
    return kCellHeight;
}

#pragma mark -
#pragma mark Actions
- (void)deleteGroupButtonDidPressed:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteGroup:)]) {
        [self.delegate deleteGroup:self.cellObject];
    }
}

@end
