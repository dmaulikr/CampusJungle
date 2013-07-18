//
//  CCEducationCell.m
//  CampusJungle
//
//  Created by Vlad Korzun on 30.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCEducationCell.h"
#import "CCEducation.h"
#import "CCViewPositioningHelper.h"

static const NSInteger kCollegeNameLabelDefaultWidth = 212;
static const NSInteger kDateLabelDefaultOriginX = 240;
static const NSInteger kDefaultCellHeight = 63;

static const CGFloat kAnimationDuration = 0.3;
static const CGFloat kSubviewsAnimationOffset = 32;

typedef void(^SimpleBlock)();
typedef void(^AnimationBlock)(SimpleBlock);

@interface CCEducationCell()

@property (nonatomic, strong) IBOutlet UILabel *collegeName;
@property (nonatomic, strong) IBOutlet UILabel *graduationDate;
@property (nonatomic, strong) IBOutlet UILabel *status;
@property (nonatomic, assign) BOOL isEditable;

@end

@implementation CCEducationCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.isEditable = NO;
}

- (void)setCellObject:(id)cellObject
{
    _cellObject = cellObject;
    self.collegeName.text = [(CCEducation *)cellObject collegeName];
    self.graduationDate.text = [(CCEducation *)cellObject graduationDate];
    self.status.text = [(CCEducation *)cellObject status];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    AnimationBlock animationBlock = ^(SimpleBlock block) {
        [UIView animateWithDuration:kAnimationDuration animations:^{
            block();
        }];
    };
    
    __weak CCEducationCell *weakSelf = self;
    if ([self isEditing] && !self.isEditable) {
        animationBlock(^{
            [CCViewPositioningHelper setWidth:kCollegeNameLabelDefaultWidth - kSubviewsAnimationOffset toView:weakSelf.collegeName];
            [CCViewPositioningHelper setOriginX:kDateLabelDefaultOriginX - kSubviewsAnimationOffset toView:weakSelf.graduationDate];
            [CCViewPositioningHelper setOriginX:kDateLabelDefaultOriginX - kSubviewsAnimationOffset toView:weakSelf.status];
        });
        self.isEditable = YES;
    }
    else if (![self isEditing] && self.isEditable) {
        animationBlock(^{
            [CCViewPositioningHelper setWidth:kCollegeNameLabelDefaultWidth toView:weakSelf.collegeName];
            [CCViewPositioningHelper setOriginX:kDateLabelDefaultOriginX toView:weakSelf.graduationDate];
            [CCViewPositioningHelper setOriginX:kDateLabelDefaultOriginX toView:weakSelf.status];
        });
        self.isEditable = NO;
    }
}

- (void)willTransitionToState:(UITableViewCellStateMask)state
{
    static const NSInteger kDeleteConfirmationCellState = 3;
    
    [super willTransitionToState:state];
    __weak CCEducationCell *weakSelf = self;
    CGFloat alpha = (state == kDeleteConfirmationCellState) ? 0 : 1;
    [UIView animateWithDuration:kAnimationDuration animations:^{
        [weakSelf.graduationDate setAlpha:alpha];
        [weakSelf.status setAlpha:alpha];
    }];
}

+ (CGFloat)heightForCellWithObject:(id)object
{
    return kDefaultCellHeight;
}

@end
