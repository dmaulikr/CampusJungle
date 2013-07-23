//
//  CCMarketFilterClassesCell.m
//  CampusJungle
//
//  Created by Vlad Korzun on 14.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCMarketFilterClassesCell.h"
#import "CCClass.h"

@interface CCMarketFilterClassesCell()

@property (nonatomic, strong) IBOutlet UILabel *label;
@property (nonatomic, strong) IBOutlet UIImageView *checkmark;

@end

@implementation CCMarketFilterClassesCell

- (void)setCellObject:(id)cellObject
{
    _cellObject = cellObject;
    self.label.text = [(CCClass *)cellObject subject];
    [self becomeSelected:[(CCClass *)cellObject isSelected]];
}

- (void)becomeSelected:(BOOL)selected
{
    [self.checkmark setHidden:!selected];
}

@end
