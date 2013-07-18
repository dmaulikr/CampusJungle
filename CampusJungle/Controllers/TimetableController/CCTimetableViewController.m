//
//  CCTimetableViewController.m
//  CampusJungle
//
//  Created by Yury Grinenko on 18.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCTimetableViewController.h"
#import "CCClass.h"
#import "CCDailyTimetableCell.h"
#import "CCTimeStringsSortingHelper.h"

@interface CCTimetableViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UILabel *classNameLabel;

@property (nonatomic, strong) CCClass *classObject;
@property (nonatomic, strong) NSArray *shortDaysOfWeek;
@property (nonatomic, strong) NSMutableDictionary *timetableDictionary;

@end

@implementation CCTimetableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupLabels];
    [self calculateTimetable];
    [self.mainTable reloadData];
    
    [self setTitle:@"Timetable"];
}

- (void)setupLabels
{
    [self.classNameLabel setText:self.classObject.name];
}

- (void)calculateTimetable
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    self.shortDaysOfWeek = [dateFormatter shortWeekdaySymbols];
    NSArray *longDaysOfWeek = [dateFormatter weekdaySymbols];
    
    self.timetableDictionary = [NSMutableDictionary dictionary];

    for (int i = 0; i < [longDaysOfWeek count]; i++) {
        NSMutableArray *timesArray = [NSMutableArray array];
        NSString *dayToSearch = [longDaysOfWeek objectAtIndex:i];
        for (NSDictionary *lessonDictionary in self.classObject.timetable) {
            if ([[lessonDictionary valueForKey:@"day"] isEqualToString:dayToSearch]) {
                [timesArray addObject:[lessonDictionary valueForKey:@"time"]];
            }
        }
        NSString *shortDayOfWeek = [self.shortDaysOfWeek objectAtIndex:i];
        NSString *timesString = [CCTimeStringsSortingHelper sortedTimesStringFromTimesStringsArray:timesArray];
        [self.timetableDictionary setValue:timesString forKey:shortDayOfWeek];
    }
}


#pragma mark -
#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.timetableDictionary allKeys] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CCDailyTimetableCell *cell = [tableView dequeueReusableCellWithIdentifier:CCTableDefines.tableCellIdentifier];
    if (!cell) {
        cell = [[CCDailyTimetableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CCTableDefines.tableCellIdentifier];
    }
    NSString *day = [self.shortDaysOfWeek objectAtIndex:indexPath.row];
    NSString *time = [self.timetableDictionary valueForKey:day];
    
    [cell setDay:day time:time];
    return cell;
}

@end
