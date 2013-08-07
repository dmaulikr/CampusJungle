//
//  CCImageCell.m
//  CampusJungle
//
//  Created by Vlad Korzun on 10.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCImageCell.h"

static const NSInteger kCellHeight = 279;

@interface CCImageCell()

@property (nonatomic, strong) IBOutlet UIImageView *pageImage;

@end

@implementation CCImageCell

- (void)setCellObject:(id)cellObject
{
    _cellObject = cellObject;
    self.pageImage.image = cellObject;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
}

+ (CGFloat)heightForCellWithObject:(id)object
{
    return kCellHeight;
}

@end
