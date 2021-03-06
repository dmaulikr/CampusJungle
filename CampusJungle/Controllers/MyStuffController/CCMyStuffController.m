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
#import "CCUserSessionProtocol.h"
#import "CCNavigationBarViewHelper.h"
#import "CCStuffCell.h"
#import "CCStuff.h"

@interface CCMyStuffController ()

@property (nonatomic, strong) id <CCUserSessionProtocol> ioc_userSession;

@end

@implementation CCMyStuffController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configTableWithProvider:[CCMyStuffDataProvider new] cellClass:[CCStuffCell class]];
    self.navigationItem.rightBarButtonItem = [CCNavigationBarViewHelper plusButtonWithTarget:self action:@selector(createNewStuff)];
    [self setTitle:@"My Stuff"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.dataSource.dataProvider loadItems];
}


- (void)createNewStuff
{
    if ([[[self.ioc_userSession currentUser] educations] count]) {
        [self.createStuffTransaction perform];
    }
    else {
        [CCStandardErrorHandler showErrorWithTitle:CCAlertsTitles.defaultError message:@"You have to join college first"];
    }
}

- (void)didSelectedCellWithObject:(id)cellObject
{
    if([cellObject isKindOfClass:[CCStuff class]]){
        [self.stuffDetailsTransaction performWithObject:cellObject];
    }
}

- (BOOL)isNeedToLeftSelected
{
    return NO;
}

@end
