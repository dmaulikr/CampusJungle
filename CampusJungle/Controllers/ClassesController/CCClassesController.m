//
//  CCClassesController.m
//  CampusJungle
//
//  Created by Yulia Petryshena on 5/31/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCClassesController.h"
#import "CCClassesDataProvider.h"
#import "CCClassCell.h"
#import "CCClassesApiProviderProtocol.h"
#import "CCClass.h"
#import "CCUserSessionProtocol.h"
#import "UIAlertView+BlocksKit.h"
#import "CCAlertDefines.h"
#import "CCAPIProviderProtocol.h"
#import "CCStandardErrorHandler.h"
#import "MBProgressHUD.h"
#import "CCEducation.h"


@interface CCClassesController ()<CellSelectionProtocol>
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

    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                 target:self
                                                                                 action:@selector(addNewClass)];
    self.navigationItem.rightBarButtonItem = rightButton;

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
        [self configTableWithProvider:self.dataProvider cellClass:[CCClassCell class]];
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
            UIAlertView *testView = [UIAlertView alertViewWithTitle:nil message:CCAlertsMessages.createCollege];
            [testView addButtonWithTitle:CCAlertsButtons.noButton handler:nil];
            [testView addButtonWithTitle:CCAlertsButtons.yesButton handler:^{
                [self.userProfileTransaction perform];
            }];
            [testView show];
        }            
            break;
        default:
            [self.selectCollege performWithObject:[[self.ioc_userSession currentUser] educations]];
            break;
    }
    
}

@end
