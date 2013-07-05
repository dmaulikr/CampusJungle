//
//  CCStateSelectionConroller.m
//  CampusJungle
//
//  Created by Vlad Korzun on 29.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCStateSelectionConroller.h"
#import "CCCommonDataSource.h"
#import "CCStatesDataProvider.h"
#import "CCStateCell.h"
#import "CCDefines.h"
#import "CCState.h"

@interface CCStateSelectionConroller ()


@property (nonatomic, strong) CCCommonDataSource *dataSource;

@end

@implementation CCStateSelectionConroller

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self configTableWithProvider:[CCStatesDataProvider new] cellClass:[CCStateCell class]];
    self.title = CCScreenTitles.stateScreenTitle;
}

- (void)didSelectedCellWithObject:(id)cellObject
{
    [self.citySelectionTransaction performWithObject:cellObject];
}

- (BOOL)isNeedToLeftSelected
{
    return NO;
}

@end
