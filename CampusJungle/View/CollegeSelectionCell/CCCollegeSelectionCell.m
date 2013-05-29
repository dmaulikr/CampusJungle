//
//  CCCollegeSellectionCell.m
//  CampusJungle
//
//  Created by Vlad Korzun on 29.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCCollegeSelectionCell.h"
#import "CCCollege.h"

@interface CCCollegeSelectionCell()

@property (nonatomic, strong) UILabel *label;

@end


@implementation CCCollegeSelectionCell

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
    self.label.text = [(CCCollege *)cellObject name];
}
@end
