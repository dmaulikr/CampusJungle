//
//  CCEducationCell.m
//  CampusJungle
//
//  Created by Vlad Korzun on 30.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCEducationCell.h"
#import "CCEducation.h"

@interface CCEducationCell()

@property (nonatomic, strong) IBOutlet UILabel *collegeName;
@property (nonatomic, strong) IBOutlet UILabel *graduationDate;
@property (nonatomic, strong) IBOutlet UILabel *status;

@end

@implementation CCEducationCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"CCEducationCell"
                                              owner:self
                                            options:nil] objectAtIndex:0];
    }
    return self;
}

- (void)setCellObject:(id)cellObject
{
    _cellObject = cellObject;
    self.collegeName.text = [(CCEducation *)cellObject collegeName];
    self.graduationDate.text = [(CCEducation *)cellObject graduationDate];
    self.status.text = [(CCEducation *)cellObject status];
}

@end
