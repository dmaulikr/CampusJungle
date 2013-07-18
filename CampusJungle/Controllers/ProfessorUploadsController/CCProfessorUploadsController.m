//
//  CCProfessorUploadsController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 18.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCProfessorUploadsController.h"
#import "CCNavigationBarViewHelper.h"

@interface CCProfessorUploadsController ()

@end

@implementation CCProfessorUploadsController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [CCNavigationBarViewHelper plusButtonWithTarget:self action:@selector(addUploads)];
    self.title = @"Professor Uploads";
}

- (void)addUploads
{
    [self.addUploadsTransaction performWithObject:self.currentClass];
}

@end
