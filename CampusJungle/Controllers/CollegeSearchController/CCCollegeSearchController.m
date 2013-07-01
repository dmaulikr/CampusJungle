//
//  CCCollegeSearchControllerViewController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 25.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCCollegeSearchController.h"
#import "CCCollegeSearchDataProvider.h"
#import "CCCollegeSelectionCell.h"

@interface CCCollegeSearchController ()

@end

@implementation CCCollegeSearchController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"CCCollegeSelectionController" bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configTableWithProvider:[CCCollegeSearchDataProvider new] cellClass:[CCCollegeSelectionCell class]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addCollege)];
}

- (void)addCollege
{
    [self.createCollegeTransaction perform];
}

- (void)didSelectedCellWithObject:(id)cellObject
{
    [self.createEducationTransaction performWithObject:cellObject];
}

@end
