//
//  CCInboxControllerViewController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 25.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCInboxController.h"
#import "CCOffersDataProvider.h"
#import "CCOrdinaryCell.h"

@interface CCInboxController ()

@end

@implementation CCInboxController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Inbox";
    [self configTableWithProvider:[CCOffersDataProvider new] cellClass:[CCOrdinaryCell class]];
}

@end
