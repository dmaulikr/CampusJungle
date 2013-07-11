//
//  CCSelectGroupViewController.m
//  CampusJungle
//
//  Created by Yury Grinenko on 11.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCSelectGroupsViewController.h"
#import "CCClass.h"
#import "CCGroup.h"

@interface CCSelectGroupsViewController ()

@property (nonatomic, strong) CCClass *classObject;
@property (nonatomic, copy) ShareItemButtonSuccessBlock successBlock;
@property (nonatomic, copy) ShareItemButtonCancelBlock cancelBlock;

@end

@implementation CCSelectGroupsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setRightNavigationItemWithTitle:@"Share" selector:@selector(shareButtonDidPressed:)];
    [self setTitle:@"Select Groups"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}

#pragma mark -
#pragma mark Actions
- (void)setClass:(CCClass *)classObject
{
    _classObject = classObject;
}

- (void)shareButtonDidPressed:(id)sender
{
    [self.backTransaction perform];
    if (self.successBlock) {
        self.successBlock(@[[CCGroup new]]);
    }
}

@end
