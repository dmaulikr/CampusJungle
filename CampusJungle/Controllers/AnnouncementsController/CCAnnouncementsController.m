//
//  CCAnnouncementsControllerViewController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 22.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAnnouncementsController.h"
#import "CCNavigationBarViewHelper.h"

@interface CCAnnouncementsController ()

@property (nonatomic, strong) id dataProvider;

@end

@implementation CCAnnouncementsController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [CCNavigationBarViewHelper plusButtonWithTarget:self action:@selector(addUploads)];
    self.title = @"Prof. Uploads";
    [self setupTableView];
}

- (void)setupTableView
{
//    self.dataProvider = [CCProfessorUploadDataProvider new];
//    self.dataProvider.delegate = self;
//    [self.dataProvider setClassID:self.currentClass.classID];
//    [self configTableWithProvider:self.dataProvider cellClass:[CCProfessorUploadsCell class]];
}

@end
