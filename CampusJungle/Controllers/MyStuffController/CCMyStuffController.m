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

@interface CCMyStuffController ()

@property (nonatomic, strong) id <CCUserSessionProtocol> ioc_userSession;

@end

@implementation CCMyStuffController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configTableWithProvider:[CCMyStuffDataProvider new] cellClass:[CCOrdinaryCell class]];
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(createNewStuff)];
}

- (void)createNewNote
{
    if([[[self.ioc_userSession currentUser] educations] count]){
        [self.createStuffTransaction perform];
    } else {
        [CCStandardErrorHandler showErrorWithTitle:nil message:@"You have to join college first"];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.dataSource.dataProvider loadItems];
}

@end
