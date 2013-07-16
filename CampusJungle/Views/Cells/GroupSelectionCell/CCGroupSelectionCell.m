//
//  CCGroupSelectionCell.m
//  CampusJungle
//
//  Created by Yury Grinenko on 12.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCGroupSelectionCell.h"
#import "CCGroup.h"

#define UNCHECKED_IMAGE [UIImage imageNamed:@"checkbox.png"]
#define CHECKED_IMAGE [UIImage imageNamed:@"checkbox_active.png"]

@interface CCGroupSelectionCell ()

@property (nonatomic, weak) IBOutlet UIImageView *checkedImageView;

@end

@implementation CCGroupSelectionCell

- (void)setCellObject:(id)cellObject
{
    [super setCellObject:cellObject];
    
    CCGroup *group = cellObject;
    [self setCellChecked:group.isSelected];
}

- (void)setCellChecked:(BOOL)checked
{
    UIImage *image = checked ? CHECKED_IMAGE : UNCHECKED_IMAGE;
    [self.checkedImageView setImage:image];
}

- (void)userDidSelectCell
{
    CCGroup *group = self.cellObject;
    group.isSelected = !group.isSelected;
    [self setCellChecked:group.isSelected];
}


@end
