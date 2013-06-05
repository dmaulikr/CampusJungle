//
//  CCCollegesListController.m
//  CampusJungle
//
//  Created by Yulia Petryshena on 6/5/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCCollegesListController.h"
#import "CCEducationsDataProvider.h"
#import "CCEducationCell.h"
#import "CCEducation.h"

@interface CCCollegesListController ()

@property (nonatomic, strong) NSArray *collegesArray;
@property (nonatomic, strong) CCEducationsDataProvider *dataProvider;

@end

@implementation CCCollegesListController

-(id)initWithArray:(NSArray*)educations
{
    self = [super init];
    if (self) {
        self.collegesArray = educations;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setTitle:@"Select College"];
    [self configTable];
}

- (void)configTable
{
    self.dataProvider = [CCEducationsDataProvider new];
    self.dataProvider.arrayOfEducations = self.collegesArray;
    
    [self configTableWithProvider:self.dataProvider cellClass:[CCEducationCell class]];
}

- (void)didSelectedCellWithObject:(id)cellObject
{
    NSLog(@"[(CCEducation *)cellObject collegeID]%@",[(CCEducation *)cellObject collegeID]);
   [self.classesOfcurrentCollegeTransaction performWithObject:[(CCEducation *)cellObject collegeID]];
}

@end
