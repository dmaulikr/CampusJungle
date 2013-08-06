//
//  CCMarketPlaceController.h
//  CampusJungle
//
//  Created by Vlad Korzun on 12.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCBaseViewController.h"
#import "CCTransactionWithObject.h"

@interface CCMarketPlaceController : CCBaseViewController

@property (nonatomic, strong) id <CCTransactionWithObject> filtersScreenTransaction;
@property (nonatomic, strong) id <CCTransactionWithObject> noteDetailsTransaction;
@property (nonatomic, strong) id <CCTransactionWithObject> fullListOfNotesTransaction;
@property (nonatomic, strong) id <CCTransactionWithObject> fullListOfStuffTransaction;
@property (nonatomic, strong) id <CCTransactionWithObject> stuffDetailsTransaction;
@property (nonatomic, strong) id <CCTransactionWithObject> bookDetailsTransaction;

@property (nonatomic, strong) NSDictionary *filters;

- (IBAction)viewAllTopNotesPressed;
- (IBAction)viewAllLatestNotesPressed;
- (IBAction)viewAllStuffButtonPressed;

- (void)update;

@end
