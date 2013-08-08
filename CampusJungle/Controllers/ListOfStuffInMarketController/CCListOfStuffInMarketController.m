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

@interface CCListOfStuffInMarketController ()

@end

@implementation CCListOfStuffInMarketController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    return  [super initWithNibName:@"CCListOfNotesInMarketController" bundle:nibBundleOrNil];
}

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


@end
