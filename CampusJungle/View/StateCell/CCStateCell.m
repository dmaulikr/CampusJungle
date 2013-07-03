//
//  CCStateCell.m
//  CampusJungle
//
//  Created by Vlad Korzun on 29.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCStateCell.h"
#import "CCState.h"

@interface CCStateCell()

@property (nonatomic, strong) UILabel *label;

@end

@implementation CCStateCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 300, 30)];
        self.label.backgroundColor = [UIColor clearColor];
        self.label.textColor = [UIColor colorWithRed:130./255 green:65./255 blue:0 alpha:1];
        [self addSubview:self.label];
        [self setSelectionColor];
    }
    return self;
}

- (void)setCellObject:(id)cellObject
{
    _cellObject = cellObject;
    self.label.text = [(CCState *)cellObject name];
}

@end
