//
//  CCClassesController.m
//  CampusJungle
//
//  Created by Yulia Petryshena on 5/31/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCClassesController.h"
#import "CCClassesDataProvider.h"
#import "CCOrdinaryCell.h"
#import "CCClassesApiProviderProtocol.h"
#import "CCClass.h"
#import "CCUserSessionProtocol.h"
#import "UIAlertView+BlocksKit.h"
#import "CCAPIProviderProtocol.h"
#import "CCStandardErrorHandler.h"
#import "MBProgressHUD.h"
#import "CCEducation.h"
#import "CCNavigationBarViewHelper.h"
#import "GIAlert.h"

@interface CCClassesController ()<CCCellSelectionProtocol>
@property (nonatomic, strong) CCClassesDataProvider *dataProvider;
@property (nonatomic, strong) id <CCUserSessionProtocol> ioc_userSession;
@property (nonatomic, strong) id <CCAPIProviderProtocol> ioc_apiProvider;
@property (nonatomic, strong) id <CCClassesApiProviderProtocol> ioc_apiClassesProvider;
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation CCClassesController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setTitle:@"My Classes"];
    self.navigationItem.rightBarButtonItem = [CCNavigationBarViewHelper plusButtonWithTarget:self action:@selector(addNewClass)];
    [self configTable];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self configTable];
}

- (void)configTable
{
    [self.ioc_apiClassesProvider getAllClasesSuccessHandler:^(NSArray *arrayOfClasses) {
        self.dataProvider.targetTable = self.table;
        self.dataProvider = [CCClassesDataProvider new];
        self.dataProvider.arrayOfClasses = arrayOfClasses;
        [self configTableWithProvider:self.dataProvider cellClass:[CCOrdinaryCell class]];
    } errorHandler:^(NSError *error) {
        [CCStandardErrorHandler showErrorWithError:error];
    } ];
}

- (void)didSelectedCellWithObject:(id)cellObject
{
    [self.classTransaction performWithObject:(CCClass*)cellObject];
}

- (void)addNewClass
{
    [[self ioc_apiProvider] loadUserInfoSuccessHandler:^(id result) {
            [[self ioc_userSession] setCurrentUser:result];
            [self performAction];
        } errorHandler:^(NSError *error) {
            [CCStandardErrorHandler showErrorWithError:error];
        }];
}

- (void)performAction
{
    NSArray *colleges = [[self.ioc_userSession currentUser] educations];
    
    switch ([colleges count]) {
        case 1: {
            NSArray *educations = [[self.ioc_userSession currentUser] educations];
            CCEducation *education = [educations objectAtIndex:0];
            [self.selectClass performWithObject:education.collegeID];
        }
            break;
        case 0: {
            GIAlertButton *noButton = [GIAlertButton cancelButtonWithTitle:CCAlertsButtons.noButton action:nil];
            GIAlertButton *yesButton = [GIAlertButton buttonWithTitle:CCAlertsButtons.yesButton action:^{
                [self.userProfileTransaction perform];
            }];
                        
            GIAlert *alert = [GIAlert alertWithTitle:nil
                                             message:CCAlertsMessages.createCollege
                                             buttons:@[noButton, yesButton,]];
            [alert show];
        }            
            break;
        default:
            [self.selectCollege performWithObject:[[self.ioc_userSession currentUser] educations]];
            break;
    }
}

@end
