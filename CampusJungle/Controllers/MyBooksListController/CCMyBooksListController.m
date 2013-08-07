//
//  CCMyBooksListController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 06.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCMyBooksListController.h"
#import "CCMyStuffDataProvider.h"
#import "CCOrdinaryCell.h"
#import "CCUserSessionProtocol.h"
#import "CCNavigationBarViewHelper.h"
#import "CCStuffCell.h"
#import "CCStuff.h"
#import "CCMyBooksDataProvider.h"
#import "CCBook.h"

@interface CCMyBooksListController ()

@property (nonatomic, strong) id <CCUserSessionProtocol> ioc_userSession;

@end

@implementation CCMyBooksListController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configTableWithProvider:[CCMyBooksDataProvider new] cellClass:[CCStuffCell class]];
    self.navigationItem.rightBarButtonItem = [CCNavigationBarViewHelper plusButtonWithTarget:self action:@selector(createNewStuff)];
    [self setTitle:@"My Books"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.dataSource.dataProvider loadItems];
}


- (void)createNewStuff
{
    if ([[[self.ioc_userSession currentUser] educations] count]) {
        [self.createBookTransaction perform];
    }
    else {
        [CCStandardErrorHandler showErrorWithTitle:CCAlertsTitles.defaultError message:@"You have to join college first"];
    }
}

- (void)didSelectedCellWithObject:(id)cellObject
{
    if([cellObject isKindOfClass:[CCBook class]]){
        [self.bookDetailsTransaction performWithObject:cellObject];
    }
}

- (BOOL)isNeedToLeftSelected
{
    return NO;
}

@end
