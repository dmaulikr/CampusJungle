//
//  CCCollegesListController.m
//  CampusJungle
//
//  Created by Yulia Petryshena on 6/5/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCCollegesListController.h"
#import "CCSideMenuDataProvider.h"

@interface CCCollegesListController ()

@property (nonatomic, strong) NSArray *collegesArray;
@property (nonatomic, strong) CCSideMenuDataProvider *dataProvider;

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
    self.dataProvider = [CCSideMenuDataProvider new];
    self.dataProvider.arrayOfItems = self.collegesArray;
    
//    [self configTableWithProvider:self.dataProvider cellClass:[CCOrdinaryCell class]];
}

@end
