//
//  CCMyStuffController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 20.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCMyStuffController.h"
#import "CCMyStuffDataProvider.h"
#import "CCOrdinaryCell.h"

@interface CCMyStuffController ()

@end

@implementation CCMyStuffController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configTableWithProvider:[CCMyStuffDataProvider new] cellClass:[CCOrdinaryCell class]];
}

@end
