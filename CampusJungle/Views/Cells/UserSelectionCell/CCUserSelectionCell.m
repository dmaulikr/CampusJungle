//
//  CCUserSelectionCell.m
//  CampusJungle
//
//  Created by Yury Grinenko on 11.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCUserSelectionCell.h"
#import "CCUser.h"

#define UNCHECKED_IMAGE [UIImage imageNamed:@"checkbox.png"]
#define CHECKED_IMAGE [UIImage imageNamed:@"checkbox_active.png"]

@interface CCUserSelectionCell ()

@property (nonatomic, weak) IBOutlet UIImageView *checkedImageView;

@end

@implementation CCUserSelectionCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)setCellObject:(id)cellObject
{
    [super setCellObject:cellObject];

    CCUser *user = cellObject;
    [self setCellChecked:user.isSelected];
}

- (void)setCellChecked:(BOOL)checked
{
    UIImage *image = checked ? CHECKED_IMAGE : UNCHECKED_IMAGE;
    [self.checkedImageView setImage:image];
}

- (void)userDidSelectCell
{
    CCUser *user = self.cellObject;
    user.isSelected = !user.isSelected;
    [self setCellChecked:user.isSelected];
}

@end
