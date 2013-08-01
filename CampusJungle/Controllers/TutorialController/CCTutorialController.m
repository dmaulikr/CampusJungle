//
//  CCTutorialController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 01.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCTutorialController.h"
#import "CCTutorialCell.h"
#import "CCTutorialDataProvider.h"

@interface CCTutorialController ()

@end

@implementation CCTutorialController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Tutorial";
}

- (void)configCollectrion
{
    [self configCollection:self.photoBrowser WithProvider:[CCTutorialDataProvider new] cellClass:[CCTutorialCell class]];
}

- (void)addRightNavBarButton
{
    [self setRightNavigationItemWithTitle:@"Skip" selector:@selector(skip)];
}


- (void)viewDidAppear:(BOOL)animated
{
    
}

- (void)skip
{
    [self.loginTransaction perform];
}

@end
