//
//  CCCollegeSelectionController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 29.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCCollegeSelectionController.h"
#import "CCCollege.h"
#import "CCCollegeSelectionDataProvider.h"
#import "CCCollegeSelectionCell.h"
#import "CCAlertDefines.h"
#import "CCAPIProviderProtocol.h"
#import "CCStandardErrorHandler.h"
#import "CCDefines.h"

@interface CCCollegeSelectionController ()

@property (nonatomic, strong) id <CCAPIProviderProtocol> ioc_apiProvider;

@end

@implementation CCCollegeSelectionController

- (void)viewDidLoad
{
    [super viewDidLoad];
    CCCollegeSelectionDataProvider *collegesProvider = [CCCollegeSelectionDataProvider new];
    collegesProvider.cityID = self.cityID;
    
    [self configTableWithProvider:collegesProvider cellClass:[CCCollegeSelectionCell class]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Add"
                                                                              style:UIBarButtonItemStyleBordered
                                                                             target:self
                                                                             action:@selector(addCollege)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.dataSource.dataProvider loadItems];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    self.dataSource.dataProvider.searchQuery = searchText;
    [self.dataSource.dataProvider loadItems];
}

- (void)didSelectedCellWithObject:(id)cellObject
{
    [self.educationTransaction performWithObject:(CCCollege *)cellObject];
}

- (void)addCollege
{
    UIAlertView *alertForCityInput = [[UIAlertView alloc] initWithTitle:@"New College" message:nil delegate:self cancelButtonTitle:CCAlertsButtons.cancelButton otherButtonTitles:CCAlertsButtons.okButton, nil];
    alertForCityInput.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    UITextField *cityName = [alertForCityInput textFieldAtIndex:0];
    cityName.placeholder = @"College Name";
    
    UITextField *address = [alertForCityInput textFieldAtIndex:1];
    address.placeholder = @"Address";
    address.secureTextEntry = NO;
    
    [alertForCityInput show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1){
        [self.ioc_apiProvider createCollege:[[alertView textFieldAtIndex:0] text] cityID:self.cityID address:[[alertView textFieldAtIndex:1] text] SuccessHandler:^(id object) {
            [self.educationTransaction performWithObject:object[CCResponseKeys.item]];
        } errorHandler:^(NSError *error) {
            [CCStandardErrorHandler showErrorWithError:error];
        }];
    }
}

@end
