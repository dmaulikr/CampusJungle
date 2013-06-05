//
//  CCClassesController.m
//  CampusJungle
//
//  Created by Yulia Petryshena on 5/31/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCClassesController.h"
#import "CCClassesDataProvider.h"
#import "CCClassCell.h"
#import "CCClassesApiProviderProtocol.h"
#import "CCClass.h"
#import "CCUserSessionProtocol.h"


@interface CCClassesController ()<CellSelectionProtocol>
@property (nonatomic, strong) CCClassesDataProvider *dataProvider;
@property (nonatomic, strong) id <CCUserSessionProtocol> ioc_userSession;
@property (nonatomic, strong) id <CCClassesApiProviderProtocol> ioc_apiClassesProvider;
@property (weak, nonatomic) IBOutlet UITableView *table;

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
    [self.ioc_apiClassesProvider getAllClasesSuccessHandler:^(NSArray *arrayOfClasses) {
        self.dataProvider.targetTable = self.table;
        self.dataProvider = [CCClassesDataProvider new];
        self.dataProvider.arrayOfClasses = arrayOfClasses;
        [self configTableWithProvider:self.dataProvider cellClass:[CCClassCell class]];
    } errorHandler:^(NSError *error) {
        NSLog(@"error %@", [error description]);
    } ];
    
}

- (void)didSelectedCellWithObject:(id)cellObject
{
    [self.classTransaction performWithObject:(CCClass*)cellObject];
}

- (void)addNewClass
{
    NSLog(@"%@", [[self.ioc_userSession currentUser] educations]); 
   //[self.addClassTransaction perform];
    CCClass *class = [CCClass new];
    class.collegeID = @"26556";
    class.professor = @"Brad Larson";
    class.subject = @"GPUImage";
    class.semester = @"2";
    class.callNumber = @"CS193p";
    class.timetable = @[@{@"day":@"Tue", @"time":@"23:00"}];
    
    [self.ioc_apiClassesProvider createClass:class successHandler:^(CCClass *newClass) {
        NSLog(@"newClass %@", newClass);
    } errorHandler:^(NSError *error) {

    }];

}

@end
