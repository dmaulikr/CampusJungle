//
//  CCDailyTimetableCell.m
//  CampusJungle
//
//  Created by Yury Grinenko on 18.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCDailyTimetableCell.h"

@interface CCDailyTimetableCell ()

@property (nonatomic, weak) IBOutlet UILabel *dayLabel;
@property (nonatomic, weak) IBOutlet UILabel *timeLabel;

@end

@implementation CCDailyTimetableCell

- (void)setDay:(NSString *)day time:(NSString *)time
{
    [self.dayLabel setText:day];
    [self.timeLabel setText:time];
}

@end
