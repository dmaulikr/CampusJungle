//
//  CCForumCell.m
//  CampusJungle
//
//  Created by Yury Grinenko on 15.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

static const NSInteger kDescriptionLabelOriginY = 30;
static const NSInteger kDefaultDescriptionLabelWidth = 246;
static const NSInteger kBottomSpace = 40;
static const NSInteger kMinCellHeight = 88;

#import "CCForumCell.h"
#import "CCUserSessionProtocol.h"
#import "CCForum.h"
#import "CCViewPositioningHelper.h"
#import "CCPluralizeHelper.h"

@interface CCForumCell ()

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, weak) IBOutlet UILabel *questionCountLabel;
@property (nonatomic, weak) IBOutlet UIButton *deleteForumButton;

@property (nonatomic, strong) id<CCUserSessionProtocol> ioc_userSession;
@property (nonatomic, weak) id<CCForumCellDelegate> delegate;

@end

@implementation CCForumCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setSelectionColor];
    [self.deleteForumButton addTarget:self action:@selector(deleteForumButtonDidPressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)prepareForReuse
{
    [CCViewPositioningHelper setWidth:kDefaultDescriptionLabelWidth toView:self.descriptionLabel];
}

- (void)setCellObject:(CCForum *)cellObject
{
    _cellObject = cellObject;
    [self fillLabels];
    [self setupDeleteButtonVisibility];
}

- (void)fillLabels
{
    [self.nameLabel setText:self.cellObject.name];
    [self.descriptionLabel setText:self.cellObject.description];
    [self.questionCountLabel setText:[NSString stringWithFormat:@"%i %@", self.cellObject.questionsCount, [CCPluralizeHelper pluralizeEntityName:@"question" withNumberOfItems:self.cellObject.questionsCount]]];
    
    [self.descriptionLabel sizeToFit];
    [CCViewPositioningHelper setOriginY:[CCViewPositioningHelper bottomOfView:self.descriptionLabel] + 5 toView:self.questionCountLabel];
}

- (void)setupDeleteButtonVisibility
{
    BOOL isHidden = YES;
    if ([self.ioc_userSession.currentUser.uid isEqualToString:self.cellObject.ownerId]) {
        isHidden = NO;
    }
    [self.deleteForumButton setHidden:isHidden];
}

+ (CGFloat)heightForCellWithObject:(CCForum *)forum
{
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:13];
    CGSize requiredSize = [forum.description sizeWithFont:font constrainedToSize:CGSizeMake(kDefaultDescriptionLabelWidth, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    return MAX(kMinCellHeight, kDescriptionLabelOriginY + requiredSize.height + kBottomSpace);
}

#pragma mark -
#pragma mark Actions
- (void)deleteForumButtonDidPressed:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteForum:)]) {
        [self.delegate deleteForum:self.cellObject];
    }
}

@end
