//
//  CCTimeTableCell.m
//  CampusJungle
//
//  Created by Vlad Korzun on 15.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCTimeTableCell.h"

@interface CCTimeTableCell()

@property (nonatomic, weak) IBOutlet UILabel *timeLabel;
@property (nonatomic, weak) IBOutlet UIButton *removeButton;

@end

@implementation CCTimeTableCell

- (void)setCellObject:(id)cellObject
{
    [self setSelectionColor];
    _cellObject = cellObject;
    NSDictionary *time = cellObject;
    self.timeLabel.text = time[@"timetable"];
    if(!time[@"time"]){
        self.removeButton.hidden = YES;
    } else {
        self.removeButton.hidden = NO;
    }
    [self.removeButton setBackgroundImage:nil forState:UIControlStateHighlighted];
    [self.removeButton setBackgroundImage:nil forState:UIControlStateNormal];
    
}



@end
