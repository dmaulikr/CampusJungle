//
//  CCEducationCreationController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 29.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCEducationCreationController.h"
#import "CCEducation.h"
#define animationDuration 0.3
#define numberOfYears 10

@interface CCEducationCreationController ()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, weak) IBOutlet UILabel *collegeLabel;
@property (nonatomic, weak) IBOutlet UISegmentedControl *segmentedControl;
@property (nonatomic, weak) IBOutlet UIView *pickerController;
@property (nonatomic, weak) IBOutlet UIPickerView *picker;
@property (nonatomic) NSInteger currentYear;

@end

@implementation CCEducationCreationController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.segmentedControl addTarget:self
                         action:@selector(segmentedControlDidChangeValue:)
               forControlEvents:UIControlEventValueChanged];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                              style:UIBarButtonItemStyleBordered
                                                                             target:self
                                                                            action:@selector(done)];
    self.pickerController.frame = CGRectMake(0, self.view.frame.size.height - self.pickerController.frame.size.height, self.view.frame.size.width, self.pickerController.frame.size.height);
    self.collegeLabel.text = self.collegeName;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    NSString *yearString = [formatter stringFromDate:[NSDate date]];
    int year;
    [[[NSScanner alloc] initWithString:yearString] scanInteger:&year];
    self.currentYear = year;
    [self.view addSubview: self.pickerController];
    [self showPicker];
}

- (void)segmentedControlDidChangeValue:(UISegmentedControl *)control
{
    if(control.selectedSegmentIndex == 0){
        [self showPicker];
    } else {
        [self hidePicker];
    }
}


- (void)showPicker
{
    [UIView animateWithDuration:animationDuration animations:^{
        self.pickerController.transform = CGAffineTransformMakeTranslation(0,0);
    }];
}

- (void)hidePicker
{
    [UIView animateWithDuration:animationDuration animations:^{
        self.pickerController.transform = CGAffineTransformMakeTranslation(0, self.pickerController.frame.size.height);
    }];
}

- (void)done
{
    CCEducation *education = [CCEducation new];
    education.collegeID = self.collegeID;
    education.collegeName = self.collegeName;
    if(self.segmentedControl.selectedSegmentIndex == 0){
        education.status = @"student";
        education.graduationDate = [NSString stringWithFormat:@"%d",[self.picker selectedRowInComponent:0] + self.currentYear];
    } else {
        education.status = @"professor";
    }
    

    [self.backToUserTransaction performWithObject:education];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return numberOfYears;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    return [NSString stringWithFormat:@"%d",(self.currentYear + row)];
}


@end
