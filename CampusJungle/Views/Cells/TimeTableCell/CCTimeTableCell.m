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

@end

@implementation CCTimeTableCell

- (void)setCellObject:(id)cellObject
{
    [self setSelectionColor];
    _cellObject = cellObject;
    NSDictionary *time = cellObject;
    self.timeLabel.text = time[@"timetable"];
}

@end
