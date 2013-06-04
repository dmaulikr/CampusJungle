//
//  CCClassesController.m
//  CampusJungle
//
//  Created by Yulia Petryshena on 5/31/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCClassesController.h"
#import "CCClassesDataProvider.h"
#import "CCOrdinaryCell.h"


@interface CCClassesController ()<CellSelectionProtocol>
@property (nonatomic, strong) CCClassesDataProvider *dataProvider;
@property (nonatomic, strong) id <CCAPIProviderProtocol> ioc_apiProvider;

@end

@implementation CCClassesController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                 target:self
                                                                                 action:@selector(addNewClass)];
    self.navigationItem.rightBarButtonItem = rightButton;
    [self configTable];
}

- (void)configTable
{
    self.dataProvider = [CCClassesDataProvider new];
    self.dataProvider.arrayOfClasses = nil;
    [self configTableWithProvider:self.dataProvider cellClass:[CCOrdinaryCell class]];
}

- (void)didSelectedCellWithObject:(id)cellObject
{
    [self.classTransaction performWithObject:nil];
}

- (void)addNewClass
{
   // [self.addClassTransaction perform];
    CCClass *class = [CCClass new];
    class.collegeID = @"26556";
    class.professor = @"Ostapec";
    class.subject = @"Delphi";
    class.semester = @"2";
    class.timetable = @[@{@"day":@"Tue", @"time":@"23:00"}];
    
    [self.ioc_apiProvider createClass:class successHandler:^(CCUser *user) {
        
    } errorHandler:^(NSError *error) {

    }];

}

@end
