//
//  CCEducationCell.m
//  CampusJungle
//
//  Created by Vlad Korzun on 30.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCEducationCell.h"
#import "CCEducation.h"
#import "CCViewPositioningHelper.h"

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
        NSLog(@"%lf",self.bounds.size.height);
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
    [self.collegeName sizeToFit];
    [CCViewPositioningHelper setOriginX:5 toView:self.collegeName];
}

- (void)prepareForReuse
{
    [CCViewPositioningHelper setWidth:230 toView:self.collegeName];
    [CCViewPositioningHelper setOriginX:5 toView:self.collegeName];
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

+ (CGFloat)heightForCellWithObject:(id)object
{
    CCEducation *education = object;
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:15];
    
    CGSize requiredSize = [education.collegeName sizeWithFont:font constrainedToSize:CGSizeMake(230, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    
    return MAX(60, requiredSize.height + 5);
}



@end
