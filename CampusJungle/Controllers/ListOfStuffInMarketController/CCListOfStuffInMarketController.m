//
//  CCListOfStuffInMarket.m
//  CampusJungle
//
//  Created by Vlad Korzun on 21.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCListOfStuffInMarketController.h"
#import "CCOrdinaryCell.h"
#import "CCStuffCell.h"
#import "CCMarketBooksDataProvider.h"
#import "CCNavigationBarViewHelper.h"

@interface CCListOfStuffInMarketController ()

@end

@implementation CCListOfStuffInMarketController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configTableWithProvider:self.tableProvider cellClass:[CCStuffCell class]];

    if([self.tableProvider isKindOfClass:[CCMarketBooksDataProvider class]]){
        self.title = @"Books";
        self.searchBar.placeholder = @"Search Book";
    } else {
        self.title = @"Stuff";
        self.searchBar.placeholder = @"Search Stuff";
    }
    self.navigationItem.rightBarButtonItem = [CCNavigationBarViewHelper plusButtonWithTarget:self action:@selector(plus)];
}

- (void)plus
{
    if([self.tableProvider isKindOfClass:[CCMarketBooksDataProvider class]]){
        [self.createBookTransaction perform];
    } else {
        [self.createStuffTransaction perform];
    }
}

- (void)didSelectedCellWithObject:(id)cellObject
{
    if([self.tableProvider isKindOfClass:[CCMarketBooksDataProvider class]]){
        [self.bookDetails performWithObject:cellObject];
    } else {
        [self.stuffDetails performWithObject:cellObject];
    }
}

- (BOOL)isNeedToLeftSelected
{
    return NO;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tableProvider loadItems];
}


@end
