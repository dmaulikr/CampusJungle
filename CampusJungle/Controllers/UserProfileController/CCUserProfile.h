//
//  CCInitialUserInfoController.h
//  CollegeConnect
//
//  Created by Vlad Korzun on 23.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCBaseViewController.h"
#import "CCTransaction.h"
#import "CCTableBaseViewController.h"
#import "JASidePanelController.h"

@interface CCUserProfile : CCTableBaseViewController

@property (nonatomic, weak) JASidePanelController *sidePanelController;
@property (nonatomic, strong) NSMutableArray *arrayOfEducations;


@property (nonatomic, strong) id<CCTransaction> logoutTransaction;
@property (nonatomic, strong) id<CCTransaction> addColegeTransaction;
@property (nonatomic, strong) id<CCTransaction> myNotesTransaction;
@property (nonatomic, strong) id<CCTransaction> myStuffTransaction;
@property (nonatomic, strong) id<CCTransaction> walletTransaction;
@property (nonatomic, strong) id<CCTransaction> settingsTransaction;
@property (nonatomic, strong) id<CCTransaction> changePasswordTransaction;
@property (nonatomic, strong) id<CCTransaction> myBooksTransaction;

@end
