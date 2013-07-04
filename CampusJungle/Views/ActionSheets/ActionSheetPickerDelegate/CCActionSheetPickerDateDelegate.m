//
//  CCActionSheetPickerDelegate.m
//  CampusJungle
//
//  Created by Yulia Petryshena on 6/13/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCActionSheetPickerDateDelegate.h"

@interface CCActionSheetPickerDateDelegate ()
{
    NSArray *daysOfTheWeek;
    NSArray *timeOftheDay;
}

@property (nonatomic, strong) NSString *selectedDay;
@property (nonatomic, strong) NSString *selectedHour;
@property (nonatomic, strong) NSString *selectedMinutes;
@property (nonatomic, strong) NSString *selectedTimeOfTheDay;

@end

@implementation CCActionSheetPickerDateDelegate


- (id)init
{
    if (self = [super init]) {
        daysOfTheWeek = @[@"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday", @"Saturday" ,@"Sunday"];
        timeOftheDay = @[@"AM", @"PM"];
        [self initializeStartParameters];
    }
    return self;
}

- (void)initializeStartParameters
{
    self.selectedDay = @"Monday";
    self.selectedHour = @"00";
    self.selectedMinutes = @"00";
    self.selectedTimeOfTheDay = @"AM";
}


- (void)actionSheetPickerDidSucceed:(AbstractActionSheetPicker *)actionSheetPicker origin:(id)origin
{
    [self sendResultString];
}

- (void)sendResultString
{
    NSString *time = [NSString stringWithFormat:@"%@:%@ %@",self.selectedHour, self.selectedMinutes, self.selectedTimeOfTheDay];
    NSString *resultMessage = [NSString stringWithFormat:@"%@ %@", self.selectedDay, time];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Timetable" object:nil userInfo:@{@"timetable":resultMessage,@"day":self.selectedDay, @"time":time}];
}

#pragma mark - UIPickerViewDataSource Implementation

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 4;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case 0: return [daysOfTheWeek count];
        case 1: return 12;
        case 2: return 60;
        case 3: return [timeOftheDay count];
    }
    return 0;
}

#pragma mark UIPickerViewDelegate Implementation

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    switch (component) {
        case 0: return 145.0f;
        case 1: return 50.0f;
        case 2: return 50.0f;
        case 3: return 55.0f;
    }
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (component) {
        case 0: return [daysOfTheWeek objectAtIndex:row];
        case 1: return  [NSString stringWithFormat:@"%d",row];
        case 2: return  [NSString stringWithFormat:@"%d",row];
        case 3: return [timeOftheDay objectAtIndex:row];
    }
    return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            self.selectedDay = [daysOfTheWeek objectAtIndex:row];
            return;
            
        case 1:
            self.selectedHour = [self addNullIfNeeded:row];
            return;
            
        case 2:
            self.selectedMinutes = [self addNullIfNeeded:row];
            return;
        case 3:
            self.selectedTimeOfTheDay = [timeOftheDay objectAtIndex:row];
            return;
    }
}

- (NSString*)addNullIfNeeded:(NSInteger)row
{
    NSString *formatString = @"%d";

    if (row < 10) {
       formatString = @"0%d";
    }
    NSString *string = [NSString stringWithFormat:formatString, row];
    return string;
}

@end
