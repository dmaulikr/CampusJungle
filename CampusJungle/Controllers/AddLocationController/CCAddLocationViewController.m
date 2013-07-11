//
//  CCAddLocationViewController.m
//  CampusJungle
//
//  Created by Yury Grinenko on 11.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAddLocationViewController.h"

#import "CCMapHelper.h"
#import "CCPlacemarkAddressHelper.h"
#import "CCKeyboardHepler.h"

#import "CCLocation.h"
#import "CCShareItemButton.h"

#import "CCStandardErrorHandler.h"
#import "CCShareItemActionSheet.h"

@interface CCAddLocationViewController () <CLLocationManagerDelegate, UITextFieldDelegate, MKMapViewDelegate>

@property (nonatomic, weak) IBOutlet MKMapView *mapView;
@property (nonatomic, weak) IBOutlet UITextField *nameTextField;
@property (nonatomic, weak) IBOutlet UITextField *descriptionTextField;
@property (nonatomic, weak) IBOutlet UITextField *addressTextField;

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CCShareItemActionSheet *shareItemActionSheet;

@end

@implementation CCAddLocationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupMapView];
    
    [self setRightNavigationItemWithTitle:@"Add" selector:@selector(addButtonDidPressed:)];
    [self setTitle:@"Add Location"];
}

- (void)setupMapView
{
    [self.mapView setDelegate:self];
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressGesture:)];
    [self.mapView addGestureRecognizer:longPressGesture];
}

- (void)setupLocationManager
{
    self.locationManager = [CLLocationManager new];
    [self.locationManager setDelegate:self];
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
}

#pragma mark -
#pragma mark Actions
- (void)findAddress
{
    if ([self.addressTextField.text length] == 0) {
        [CCStandardErrorHandler showErrorWithTitle:CCAlertsTitles.defaultError message:CCAlertsMessages.incorrectAddress];
        return;
    }
    [CCMapHelper removeAllAnnotationsInMap:self.mapView];
    [self.addressTextField resignFirstResponder];
    __weak CCAddLocationViewController *weakSelf = self;
    CLGeocoder *geocoder = [CLGeocoder new];
    [geocoder geocodeAddressString:self.addressTextField.text completionHandler:^(NSArray *placemarks, NSError *error) {
        if (placemarks && placemarks.count > 0)  {
            CLPlacemark *topPlacemark = [placemarks objectAtIndex:0];
            MKPlacemark *mapPlacemark = [[MKPlacemark alloc] initWithPlacemark:topPlacemark];
            [weakSelf.mapView addAnnotation:mapPlacemark];
            [CCMapHelper focusOnCLLocation:topPlacemark.location inMap:weakSelf.mapView];
        }
        else {
            [CCStandardErrorHandler showErrorWithTitle:CCAlertsTitles.defaultError message:CCAlertsMessages.notAccurateAddress];
        }
    }];
}

- (void)addButtonDidPressed:(id)sender
{
    if ([self validateInputData]) {
        [self showShareItemActionSheet];
    }
}

- (void)showShareItemActionSheet
{
    [CCKeyboardHepler hideKeyboard];
    [self createShareItemActionSheet];
    [self.shareItemActionSheet show];
}

- (void)createShareItemActionSheet
{
    NSArray *shareItemActionSheetButtons = [self shareItemActionSheetButtons];
    self.shareItemActionSheet = [[CCShareItemActionSheet alloc] initWithTitle:@"Share Options" buttonsArray:shareItemActionSheetButtons];    
}

- (NSArray *)shareItemActionSheetButtons
{
    __weak CCAddLocationViewController *weakSelf = self;
    CCShareItemButton *shareWithClassButton = [CCShareItemButton buttonWithTitle:@"Share with Class" actionBlock:^{
        [weakSelf.shareItemActionSheet dismiss];
    }];
    CCShareItemButton *shareWithGroupButton = [CCShareItemButton buttonWithTitle:@"Share with Group" actionBlock:^{
        [weakSelf.selectGroupToShareTransaction performWithObject:weakSelf.locationToAddobject];
        [weakSelf.shareItemActionSheet dismiss];
    }];
    CCShareItemButton *shareWithClassmatesButton = [CCShareItemButton buttonWithTitle:@"Share with Classmates" actionBlock:^{
        [weakSelf.selectUsersToShareTransaction performWithObject:weakSelf.locationToAddobject];
        [weakSelf.shareItemActionSheet dismiss];
    }];
    
    
    return @[shareWithClassButton, shareWithGroupButton, shareWithClassmatesButton];
}

- (IBAction)detectCurrentPositionButtonDidPressed:(id)sender
{
    [CCMapHelper removeAllAnnotationsInMap:self.mapView];
    if (!self.locationManager) {
        [self setupLocationManager];
    }
    [self setRightNavigationBarButtonEnabled:NO];
    [self.locationManager startUpdatingLocation];
}

- (void)handleLongPressGesture:(UIGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded || sender.state == UIGestureRecognizerStateChanged) {
        return;
    }
    [CCMapHelper removeAllAnnotationsInMap:self.mapView];
    CGPoint point = [sender locationInView:self.mapView];
    CLLocationCoordinate2D coordinates = [self.mapView convertPoint:point toCoordinateFromView:self.mapView];
    CCLocation *location = [CCLocation createWithCoordinates:coordinates];
    [CCMapHelper createAnnotationsOnMap:self.mapView withLocationsArray:@[location]];
    [CCMapHelper focusOnLocation:location inMap:self.mapView];
}

- (void)updateAddressData
{
    if ([self.mapView.annotations count] > 0) {
        [self.addressTextField setEnabled:NO];
        MKPointAnnotation *point = [[self.mapView annotations] objectAtIndex:0];
        CLLocation *location = [[CLLocation alloc] initWithLatitude:point.coordinate.latitude longitude:point.coordinate.longitude];
        CLGeocoder *geocoder = [CLGeocoder new];
        __weak CCAddLocationViewController *weakSelf = self;
        [self setRightNavigationBarButtonEnabled:NO];
        [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
            NSString *addressString = @"Unknown";
            if (placemarks && [placemarks count] > 0) {
                CLPlacemark *firstPlacemark = [placemarks objectAtIndex:0];
                addressString = [CCPlacemarkAddressHelper addressForPlacemark:firstPlacemark];
            }
            [weakSelf.addressTextField setText:addressString];
            [weakSelf.addressTextField setEnabled:YES];
            [weakSelf setRightNavigationBarButtonEnabled:YES];
        }];
    }
}

- (void)setRightNavigationBarButtonEnabled:(BOOL)enabled
{
    [self.navigationItem.rightBarButtonItem setEnabled:enabled];
}

#pragma mark -
#pragma mark Data Validation
- (BOOL)validateInputData
{
    if ([self.addressTextField.text length] == 0 || [self.mapView.annotations count] == 0) {
        [CCStandardErrorHandler showErrorWithTitle:CCAlertsTitles.defaultError message:CCAlertsMessages.emptyLocationAddress];
        return NO;
    }
    else if ([self.nameTextField.text length] == 0) {
        [CCStandardErrorHandler showErrorWithTitle:CCAlertsTitles.defaultError message:CCAlertsMessages.emptyLocationName];
        return NO;
    }
    else if ([self.descriptionTextField.text length] == 0) {
        [CCStandardErrorHandler showErrorWithTitle:CCAlertsTitles.defaultError message:CCAlertsMessages.emptyLocationDescription];
        return NO;
    }
    return YES;
}

#pragma mark -
#pragma mark CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [CCStandardErrorHandler showErrorWithError:error];
    [self.locationManager stopUpdatingLocation];
    [self setRightNavigationBarButtonEnabled:YES];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    CLLocation *currentLocation = newLocation;
    if (currentLocation != nil) {
        CCLocation *location = [CCLocation createUsingLocation:currentLocation];
        [CCMapHelper createAnnotationsOnMap:self.mapView withLocationsArray:@[location]];
        [CCMapHelper focusOnCLLocation:currentLocation inMap:self.mapView];
    }
    [self.locationManager stopUpdatingLocation];
    [self setRightNavigationBarButtonEnabled:YES];
}

#pragma mark -
#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.addressTextField) {
        [self findAddress];
    }
    else if (textField == self.nameTextField) {
        [self.descriptionTextField becomeFirstResponder];
    }
    else {
        [self.descriptionTextField resignFirstResponder];
    }
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (textField == self.addressTextField) {
        [self findAddress];
    }
    return YES;
}

#pragma mark -
#pragma mark MKMapViewDelegate
- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    [self updateAddressData];
}

@end
