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

#define offsetForDate 27
#define offsetForCollegeName 10

@end

@implementation CCEducationCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"CCEducationCell"
                                              owner:self
                                            options:nil] objectAtIndex:0];
        [self setSelectionColor];
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

- (void)layoutSubviews
{
    if(self.editing){
        self.collegeName.transform = CGAffineTransformMakeTranslation(-offsetForCollegeName, 0);
        self.graduationDate.transform = CGAffineTransformMakeTranslation(-offsetForDate, 0);
        self.status.transform = CGAffineTransformMakeTranslation(-offsetForDate, 0);
    } else {
        self.collegeName.transform = CGAffineTransformMakeTranslation(0, 0);
        self.graduationDate.transform = CGAffineTransformMakeTranslation(0, 0);
        self.status.transform = CGAffineTransformMakeTranslation(0, 0);
    }
    [super layoutSubviews];
}

@end
