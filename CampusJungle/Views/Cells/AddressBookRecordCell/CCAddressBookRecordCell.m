//
//  CCAddressBookRecordCell.m
//  CampusJungle
//
//  Created by Yury Grinenko on 26.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAddressBookRecordCell.h"
#import "CCViewPositioningHelper.h"

#import "CCAddressBookRecord.h"

#define UNCHECKED_IMAGE [UIImage imageNamed:@"checkbox.png"]
#define CHECKED_IMAGE [UIImage imageNamed:@"checkbox_active.png"]

@interface CCAddressBookRecordCell ()

@property (nonatomic, weak) IBOutlet UILabel *userNameLabel;
@property (nonatomic, weak) IBOutlet UIImageView *checkedImageView;
@property (nonatomic, strong) CCAddressBookRecord *record;

@end

@implementation CCAddressBookRecordCell

- (void)setCellObject:(CCAddressBookRecord *)record
{
    self.record = record;
    [self fillLabels];
    [self fillImageView];
}

- (void)fillLabels
{
    [self.userNameLabel setText:[NSString stringWithFormat:@"%@ %@", self.record.firstName, self.record.lastName]];
}

- (void)fillImageView
{
    [self setChecked:self.record.checked];
}

- (void)addBottomDivider
{
    [super addBottomDivider];
    [CCViewPositioningHelper setOriginY:[CCViewPositioningHelper bottomOfView:self.bottomDivider] toView:self.bottomDivider];
}

#pragma mark -
#pragma mark Actions
- (void)userTapsToSelectEmails
{
    [self userTapsToSelectFromValues:self.record.emails withAlreadySelectedItems:self.record.checkedEmails];
}

- (void)userTapsToSelectPhoneNumbers
{
    [self userTapsToSelectFromValues:self.record.phoneNumbers withAlreadySelectedItems:self.record.checkedPhoneNumbers];
}

- (void)userTapsToSelectFromValues:(NSArray *)values withAlreadySelectedItems:(NSMutableArray *)selectedValues
{
    if ([values count] > 1) {
        [self showMultipleSelectionAlertWithValues:values selectedValues:selectedValues];
    }
    else {
        if (self.record.checked) {
            [self setChecked:NO];
            [selectedValues removeAllObjects];
        }
        else {
            [self setChecked:YES];
            [selectedValues addObjectsFromArray:values];
        }
    }
}

- (void)showMultipleSelectionAlertWithValues:(NSArray *)valuesArray selectedValues:(NSMutableArray *)selectedValues
{
//  TODO Maybe in future: alert with tableview
    [selectedValues addObject:[valuesArray objectAtIndex:0]];
    [self setChecked:!self.record.checked];
}

- (void)setChecked:(BOOL)checked
{
    self.record.checked = checked;
    UIImage *image = checked ? CHECKED_IMAGE : UNCHECKED_IMAGE;
    [self.checkedImageView setImage:image];
}

@end