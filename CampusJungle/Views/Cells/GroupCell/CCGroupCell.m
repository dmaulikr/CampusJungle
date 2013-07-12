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

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setSelectionColor];
}

- (void)setCellObject:(id)cellObject
{
    _cellObject = cellObject;
    [self.nameLabel setText:[self.cellObject name]];
    [self fillImageView];
}

- (void)fillImageView
{
    NSURL *groupImageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",CCAPIDefines.baseURL, self.cellObject.image]];
    [self.groupImageView setImageWithURL:groupImageUrl placeholderImage:[UIImage imageNamed:@"avatar_placeholder"]];
}

+ (CGFloat)heightForCellWithObject:(id)object
{
    return 44;
}

@end
