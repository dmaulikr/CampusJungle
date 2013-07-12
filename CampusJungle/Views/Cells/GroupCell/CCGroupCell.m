//
//  CCGroupCell.m
//  CampusJungle
//
//  Created by Yury Grinenko on 12.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCGroupCell.h"
#import "CCGroup.h"

@interface CCGroupCell ()

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UIImageView *groupImageView;

@end

@implementation CCGroupCell

- (void)setCellObject:(id)cellObject
{
    _cellObject = cellObject;
    [self.nameLabel setText:[(CCGroup *)cellObject name]];
}

+ (CGFloat)heightForCellWithObject:(id)object
{
    return 44;
}

@end
