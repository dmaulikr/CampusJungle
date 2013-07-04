//
//  CCCitySelectionScreenViewController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 29.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCCitySelectionController.h"
#import "CCCityCell.h"
#import "CCCitiesDataProvider.h"
#import "CCCity.h"
#import "CCAPIProviderProtocol.h"
#import "CCStandardErrorHandler.h"
#import "CCNavigationBarViewHellper.h"

@interface CCCitySelectionController ()<UIAlertViewDelegate>

@property (nonatomic, strong) id <CCAPIProviderProtocol> ioc_apiProvider;
@property (nonatomic, strong) NSNumber *cityID;

@end
 
@implementation CCCitySelectionController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CCCitiesDataProvider *citiesProvider = [CCCitiesDataProvider new];
    citiesProvider.stateID = self.stateID;

    [self configTableWithProvider:citiesProvider cellClass:[CCCityCell class]];
    self.navigationItem.rightBarButtonItem = [CCNavigationBarViewHellper plusButtonWithTarget:self action:@selector(addCity)];
}

- (void)didSelectedCellWithObject:(id)cellObject
{
    self.cityID = [(CCCity *)cellObject cityID];
    [self addCollege];

}

- (BOOL)isNeedToLeftSelected
{
    return NO;
}

- (void)addCity
{
    UIAlertView *alertForCityInput = [[UIAlertView alloc] initWithTitle:@"New city" message:nil delegate:self cancelButtonTitle:CCAlertsButtons.cancelButton otherButtonTitles:CCAlertsButtons.okButton, nil];
    alertForCityInput.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField *cityName = [alertForCityInput textFieldAtIndex:0];
    cityName.placeholder = @"City Name";
    [alertForCityInput show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if([alertView.title isEqualToString:@"New city"]){
        if(buttonIndex == 1){
            [self.ioc_apiProvider createCity:[[alertView textFieldAtIndex:0] text] stateID:self.stateID SuccessHandler:^(NSDictionary *object) {
                self.cityID = [object[@"item"] cityID];
                [self addCollege];
            } errorHandler:^(NSError *error) {
                [CCStandardErrorHandler showErrorWithError:error];
            }];
        }
    } else {
        if(buttonIndex == 1){
            [self.ioc_apiProvider createCollege:[[alertView textFieldAtIndex:0] text] cityID:self.cityID address:[[alertView textFieldAtIndex:1] text] SuccessHandler:^(id object) {
                [self.educationTransaction performWithObject:object[CCResponseKeys.item]];
            } errorHandler:^(NSError *error) {
                [CCStandardErrorHandler showErrorWithError:error];
            }];
        }
    }
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


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.dataSource.dataProvider loadItems];
}

@end
