//
//  CCCollegeClassesController.m
//  CampusJungle
//
//  Created by Yulia Petryshena on 6/5/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCCollegeClassesController.h"
#import "CCClassesApiProviderProtocol.h"
#import "CCClassesDataProvider.h"
#import "CCClassCell.h"
#import "CCStandardErrorHandler.h"
#import "CCClass.h"

@interface CCCollegeClassesController ()

@property (nonatomic, strong) NSString *collegeID;
@property (nonatomic, strong) CCClassesDataProvider *dataProvider;
@property (nonatomic, strong) id <CCClassesApiProviderProtocol> ioc_apiClassesProvider;

@end

@implementation CCCollegeClassesController

- (id)initWithCollegeID:(NSString*)collegeID
{
    self = [super init];
    if (self) {
        self.collegeID = collegeID;
        [self.navigationItem setTitle:@"Join Class"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addButton];
    [self.ioc_apiClassesProvider getClassesOfCollege:self.collegeID successHandler:^(id response) {
        self.dataProvider = [CCClassesDataProvider new];
        self.dataProvider.arrayOfClasses = response;
        [self configTableWithProvider:self.dataProvider cellClass:[CCClassCell class]];
    } errorHandler:^(NSError *error) {
        [CCStandardErrorHandler showErrorWithError:error];
    }];
}

- (void)addButton
{
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                 target:self
                                                                                 action:@selector(addNewClass)];
    self.navigationItem.rightBarButtonItem = rightButton;

}

- (void)addNewClass
{
    [self.addNewClassTransaction performWithObject:self.collegeID];
    
}

- (void)didSelectedCellWithObject:(id)cellObject
{
    [self.ioc_apiClassesProvider joinClass:[(CCClass *)cellObject classID] SuccessHandler:^(id response) {
        [self.classAddedTransaction perform];
    } errorHandler:^(NSError *error) {
        [CCStandardErrorHandler showErrorWithError:error];
    }];
    
}

@end
