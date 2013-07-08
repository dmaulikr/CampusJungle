//
//  CCClassController.m
//  CampusJungle
//
//  Created by Yulia Petryshena on 6/5/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCClassController.h"
#import "CCClass.h"
#import "CCClassmatesDataProvider.h"
#import "CCUserCell.h"
#import "CCClassTableController.h"
#import "CCCellSelectionProtocol.h"
#import "GIAlert.h"
#import "CCClassesApiProviderProtocol.h"
#import "CCStandardErrorHandler.h"

@interface CCClassController ()<CCCellSelectionProtocol>

@property (nonatomic, weak) IBOutlet UILabel *classNumber;
@property (nonatomic, weak) IBOutlet UILabel *professor;
@property (nonatomic, weak) IBOutlet UIImageView *avatarImage;
@property (nonatomic, weak) IBOutlet UIView *headerView;
@property (nonatomic, strong) CCClassTableController *classContentTable;
@property (nonatomic, strong) id <CCClassesApiProviderProtocol> ioc_classesApiProvider;

@property (nonatomic, strong) CCClass *currentClass;

- (IBAction)leaveClassButtonDidPress;

@end

@implementation CCClassController

- (id)initWithClass:(CCClass *)classObject
{
    self = [super init];
    if (self) {
        self.currentClass = classObject;
        [self.navigationItem setTitle:classObject.subject];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadInfo];
    [self setRightNavigationItemWithTitle:@"Edit" selector:@selector(editClass)];
    [self setButtonsTextColorInView:self.headerView];
    CCClassmatesDataProvider *classmateDataprovider = [CCClassmatesDataProvider new];
    classmateDataprovider.classID = self.currentClass.classID;
   
    self.classContentTable = [CCClassTableController new];
    self.classContentTable.tableHeaderView = self.headerView;
    self.classContentTable.classID = self.currentClass.classID;
    self.classContentTable.delegate = self;
    [self.view addSubview:self.classContentTable.view];
}

- (void)loadInfo
{
    self.navigationController.navigationItem.title = self.currentClass.subject;
    self.professor.text = self.currentClass.professor;
    self.classNumber.text = self.currentClass.callNumber;
}

- (void)editClass
{
    
}

- (IBAction)classMarketButtonDidPressed
{
    [self.classMarketTransaction performWithObject:self.currentClass];
}

- (void)didSelectedCellWithObject:(id)cellObject
{
    [self.otherUserProfileTransaction performWithObject:cellObject];
}

- (BOOL)isNeedToLeftSelected
{
    return NO;
}

- (IBAction)leaveClassButtonDidPress
{
    [self showConfirmWithSuccess:^{
        [self.ioc_classesApiProvider leaveClassWithID:self.currentClass.classID SuccessHandler:^(id result) {
            [[NSNotificationCenter defaultCenter] postNotificationName:CCNotificationsNames.reloadSideMenu object:nil];
            [self.newsFeedTransaction perform];
        } errorHandler:^(NSError *error) {
            [CCStandardErrorHandler showErrorWithError:error];
        }];
    }];
}

- (void)showConfirmWithSuccess:(successHandler)success
{
    GIAlertButton *noButton = [GIAlertButton cancelButtonWithTitle:CCAlertsButtons.noButton action:nil];
    GIAlertButton *yesButton = [GIAlertButton buttonWithTitle:CCAlertsButtons.yesButton action:success];
    
    GIAlert *alert = [GIAlert alertWithTitle:CCAlertsMessages.confirmation
                                     message:CCAlertsMessages.confirmationMessage
                                     buttons:@[noButton, yesButton]];
    [alert show];
}


@end
