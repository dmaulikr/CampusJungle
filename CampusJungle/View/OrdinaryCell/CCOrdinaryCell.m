//
//  CCOrdinaryCell.m
//  CampusJungle
//
//  Created by Yulia Petryshena on 5/30/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCOrdinaryCell.h"

@interface CCOrdinaryCell()

@property (nonatomic, strong) UILabel *label;

@end

@implementation CCOrdinaryCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 300, 30)];
        [self addSubview:self.label];
    }
    return self;
}

- (void)setCellObject:(id)cellObject
{
    _cellObject = cellObject;
    self.label.text = (NSString *)cellObject;
}

@end
