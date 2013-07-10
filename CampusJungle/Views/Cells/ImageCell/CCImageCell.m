//
//  CCImageCell.m
//  CampusJungle
//
//  Created by Vlad Korzun on 10.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCImageCell.h"

@interface CCImageCell()

@property (nonatomic, strong) IBOutlet UIImageView *pageImage;

@end

@implementation CCImageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"CCImageCell"
                                              owner:self
                                            options:nil] objectAtIndex:0];
        
    }
    return self;
}

- (void)setCellObject:(id)cellObject
{
    _cellObject = cellObject;
    self.pageImage.image = cellObject;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
}

@end
