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

@property (nonatomic, weak) UIPickerView *picker;

@end

@implementation CCActionSheetPickerDateDelegate

- (id)initWithDate:(NSDictionary *)date
{
    if (self = [super init]) {
        NSDateFormatter *dateFormatter = [NSDateFormatter new];
        daysOfTheWeek = [dateFormatter weekdaySymbols];
        timeOftheDay = @[@"AM", @"PM"];
        if(date){
            self.beginTime = date;
        } else {
            [self initializeStartParameters];
        }
    }
    return self;
}

- (void)initializeStartParameters
{
    self.selectedDay = daysOfTheWeek[0];
    self.selectedHour = @"01";
    self.selectedMinutes = @"00";
    self.selectedTimeOfTheDay = @"AM";
}

- (void)setBeginTime:(NSDictionary *)beginTime
{
    _beginTime = beginTime;
    NSDictionary *separatedTime = [self separeteTime:self.beginTime];
    self.selectedDay = separatedTime[@"day"];
    self.selectedHour = separatedTime[@"hour"];
    self.selectedMinutes = separatedTime[@"min"];
    self.selectedTimeOfTheDay = separatedTime[@"timeOfDay"];
}

- (NSDictionary *)separeteTime:(NSDictionary *)time
{
    NSMutableDictionary *separatedTime = [NSMutableDictionary new];
    [separatedTime addEntriesFromDictionary:@{@"day" : time[@"day"]}];
    NSString *timeAsString = time[@"time"];
    timeAsString = [timeAsString stringByReplacingOccurrencesOfString:@" " withString:@":"];
    NSArray *timeAsStringSubstrings = [timeAsString componentsSeparatedByString:@":"];
    [separatedTime addEntriesFromDictionary:@{
     @"hour" : timeAsStringSubstrings[0],
     @"min" : timeAsStringSubstrings[1],
     @"timeOfDay": timeAsStringSubstrings[2],
     }];
    return separatedTime;
}

- (void)setSelectedItems
{
    [self.picker selectRow:[daysOfTheWeek indexOfObject:self.selectedDay] inComponent:0 animated:NO];
    [self.picker selectRow:[self.selectedHour integerValue] - 1 inComponent:1 animated:NO];
    [self.picker selectRow:[self.selectedMinutes integerValue] inComponent:2 animated:NO];
    [self.picker selectRow:[timeOftheDay indexOfObject:self.selectedTimeOfTheDay] inComponent:3 animated:NO];

}

- (void)actionSheetPickerDidSucceed:(AbstractActionSheetPicker *)actionSheetPicker origin:(id)origin
{
    [self sendResultString];
}

- (void)sendResultString
{
    NSString *time = [NSString stringWithFormat:@"%@:%@ %@",self.selectedHour, self.selectedMinutes, self.selectedTimeOfTheDay];
    NSString *resultMessage = [NSString stringWithFormat:@"%@ %@", self.selectedDay, time];
    if(self.beginTime){
        [self.delegate lesson:self.beginTime didUpdateWithObject:@{@"timetable":resultMessage,@"day":self.selectedDay, @"time":time}];
    } else {
        [self.delegate lessonDidCreate:@{@"timetable":resultMessage,@"day":self.selectedDay, @"time":time}];
    }

}

#pragma mark - UIPickerViewDataSource Implementation

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    self.picker = pickerView;
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
        case 1: return  [NSString stringWithFormat:@"%02d", row + 1];
        case 2: return  [NSString stringWithFormat:@"%02d", row];
        case 3: {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setSelectedItems];
            });
            return [timeOftheDay objectAtIndex:row];
        }
    }
    return nil;
}

- (void)configurePickerView:(UIPickerView *)pickerView
{
    self.picker = pickerView;
    [self setSelectedItems];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            self.selectedDay = [daysOfTheWeek objectAtIndex:row];
            return;
            
        case 1:
            self.selectedHour = [self stringValueOfRow:row + 1];
            return;
            
        case 2:
            self.selectedMinutes = [self stringValueOfRow:row];
            return;
        case 3:
            self.selectedTimeOfTheDay = [timeOftheDay objectAtIndex:row];
            return;
    }
}

- (NSString *)stringValueOfRow:(NSInteger)row
{
    return [NSString stringWithFormat:@"%02d", row];
}

@end
