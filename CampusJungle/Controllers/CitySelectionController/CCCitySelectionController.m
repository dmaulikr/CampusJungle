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
#import "CCDefines.h"
#import "CCAlertDefines.h"
#import "CCAPIProviderProtocol.h"
#import "CCStandardErrorHandler.h"
#import "CCNavigationBarViewHelper.h"
#import "GIInputAlert.h"

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
    self.navigationItem.rightBarButtonItem = [CCNavigationBarViewHelper plusButtonWithTarget:self action:@selector(addCity)];
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
    GIInputAlert *alertForCity = [GIInputAlert alertWithTitle:@"New City" numberOfFields:1 buttons:nil];
    GIAlertButton *okButton = [GIAlertButton buttonWithTitle:CCAlertsButtons.okButton
                                                      action:^{
                                                          [self createCityWithName:alertForCity.firstField.text];
                                                      }];
    GIAlertButton *cancelButton = [GIAlertButton cancelButtonWithTitle:CCAlertsButtons.cancelButton action:nil];
    
    alertForCity.arrayOfButtons = @[cancelButton,okButton];
    [alertForCity show];
    alertForCity.firstField.placeholder = @"City Name";
}

- (void)addCollege
{
    GIInputAlert *alertForCollege = [GIInputAlert alertWithTitle:@"New College" numberOfFields:2 buttons:nil];
    GIAlertButton *okButton = [GIAlertButton buttonWithTitle:CCAlertsButtons.okButton
                                                      action:^{
                                                          [self createCollege:alertForCollege.firstField.text
                                                                      address:alertForCollege.secondField.text];
                                                      }];
    GIAlertButton *cancelButton = [GIAlertButton cancelButtonWithTitle:CCAlertsButtons.cancelButton action:nil];
    
    alertForCollege.arrayOfButtons = @[cancelButton,okButton];
    [alertForCollege show];
    
    alertForCollege.firstField.placeholder = @"College Name";
    alertForCollege.secondField.placeholder = @"Address";
}

- (void)createCityWithName:(NSString *)name
{
    [self.ioc_apiProvider createCity:name stateID:self.stateID SuccessHandler:^(NSDictionary *object) {
        self.cityID = [object[@"item"] cityID];
        [self addCollege];
    } errorHandler:^(NSError *error) {
        [CCStandardErrorHandler showErrorWithError:error];
    }];
}

- (void)createCollege:(NSString *)name address:(NSString *)address
{
    [self.ioc_apiProvider createCollege:name cityID:self.cityID address:address SuccessHandler:^(id object) {
        [self.educationTransaction performWithObject:object[CCResponseKeys.item]];
    } errorHandler:^(NSError *error) {
        [CCStandardErrorHandler showErrorWithError:error];
    }];

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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.dataSource.dataProvider loadItems];
}

@end
