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

@property (nonatomic, strong) IBOutlet UILabel *collegeName;

@end


@implementation CCCollegeSelectionCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"CCCollegeSelectionCell" owner:self options:nil][0];
        [self setSelectionColor];
    }
    return self;
}

- (void)setCellObject:(id)cellObject
{
    _cellObject = cellObject;
    self.collegeName.text = [(CCCollege *)cellObject name];
}

@end
