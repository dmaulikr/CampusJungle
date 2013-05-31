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
@end

@implementation CCClassesController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:nil
                                                                              style:UIBarButtonSystemItemAdd
                                                                             target:self
                                                                             action:@selector(addNewClass)];
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
    [self.addClassTransaction perform];
}

@end
