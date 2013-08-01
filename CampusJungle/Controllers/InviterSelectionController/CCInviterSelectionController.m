//
//  CCInviterSelectionController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 31.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCInviterSelectionController.h"
#import "CCUserDataProvider.h"
#import "CCUserCell.h"

@interface CCInviterSelectionController ()

@property (nonatomic, strong) CCUserDataProvider *dataProvider;

@end

@implementation CCInviterSelectionController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Inviter";
    self.dataProvider = [CCUserDataProvider new];
    [self setRightNavigationItemWithTitle:@"Skip" selector:@selector(skip)];
    [self configTableWithProvider:self.dataProvider cellClass:[CCUserCell class]];
}

- (void)skip
{
    [self.tutorialTransaction perform];
}

- (void)didSelectedCellWithObject:(id)cellObject
{
    [self.tutorialTransaction perform];
}

@end
