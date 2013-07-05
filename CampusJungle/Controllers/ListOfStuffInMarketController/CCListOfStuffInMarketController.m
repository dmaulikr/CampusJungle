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
    self.title = @"Stuff";
}

- (void)didSelectedCellWithObject:(id)cellObject
{
    [self.stuffDetails performWithObject:cellObject];
}


@end
