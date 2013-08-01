//
//  CCWalletController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 30.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCWalletController.h"
#import "CCUserSessionProtocol.h"
#import "PayPalMobile.h"
#import "CCStandardErrorHandler.h"
#import "CCAppearanceConfigurator.h"
#import <StoreKit/StoreKit.h>
#import "CCStoreObserver.h"
#import "CCPaymentServiceProtocol.h"

#define firstPriceLevel 1
#define secondPriceLevel 2
#define thirdPriceLevel 3

@interface CCWalletController ()<PayPalPaymentDelegate, CCStoreObserverDelegateProtocol>

@property (nonatomic, strong) id <CCUserSessionProtocol> ioc_userSession;
@property (nonatomic, weak) IBOutlet UILabel *walletLabel;
@property (nonatomic, strong) NSArray *products;
@property (nonatomic, strong) id <CCStoreObserverProtocol> ioc_stroreObserver;
@property (nonatomic, strong) id <CCPaymentServiceProtocol> ioc_paymentManager;
@property (nonatomic, strong) SKProductsRequest *request;

- (IBAction)payPalButtonPressed:(UIButton *)sender;
- (IBAction)inAppPurcaseButtonDidPressed:(UIButton *)sender;

@end

@implementation CCWalletController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.ioc_stroreObserver setDelegate:self];
    self.title = @"Wallet";
    if ([SKPaymentQueue canMakePayments]) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [self.ioc_stroreObserver loadProducts]; 
    } else {
    
    }
    float dollars = [[[self.ioc_userSession currentUser] wallet] floatValue]/100;
    self.walletLabel.text = [NSString stringWithFormat:@"$%0.2lf",dollars];
}

- (void)productsDidLoaded:(NSArray *)arrayOfProducts
{
    self.products = arrayOfProducts;
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

- (IBAction)payPalButtonPressed:(UIButton *)sender
{
    switch (sender.tag) {
        case firstPriceLevel:{
            [self makePayPalPayment:@(10)];
        } break;
        case secondPriceLevel:{
            [self makePayPalPayment:@(20)];
        } break;
        case thirdPriceLevel:{
            [self makePayPalPayment:@(30)];
        } break;
    }
}

- (void)makePayPalPayment:(NSNumber *)amount
{
    PayPalPayment *payment = [[PayPalPayment alloc] init];
    payment.amount = [[NSDecimalNumber alloc] initWithString:amount.stringValue];
    payment.currencyCode = @"USD";
    payment.shortDescription = @"Payment for virtual money";
        
    if (payment.processable) {
        [self performPayment:payment];
    } else {
        [CCStandardErrorHandler showErrorWithTitle:@"Error" message:@"Not vaild data"];
    }
}

- (void)performPayment:(PayPalPayment *)payment
{
    [PayPalPaymentViewController setEnvironment:PayPalEnvironmentSandbox];
    
    NSString *aPayerId = [[self.ioc_userSession currentUser] uid];
    PayPalPaymentViewController *paymentViewController;
    paymentViewController = [[PayPalPaymentViewController alloc]
                             initWithClientId:CCPayPalDefines.clientID
                             receiverEmail:CCPayPalDefines.reciverEmail
                             payerId:aPayerId
                             payment:payment
                             delegate:self];
    [self setDefaultConfiguration];
    [self presentViewController:paymentViewController animated:YES completion:nil];
}

#pragma mark - PayPalPaymentDelegate methods

- (void)payPalPaymentDidComplete:(PayPalPayment *)completedPayment {
    [self setCustomConfiguration];
    [SVProgressHUD showSuccessWithStatus:@"Payment is successfully performed"];
    [self.ioc_paymentManager addPayPalPayment:completedPayment.confirmation];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)payPalPaymentDidCancel {
    [self setCustomConfiguration];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)inAppPurcaseButtonDidPressed:(UIButton *)sender
{
    SKProduct *selectedProduct = nil;
    switch (sender.tag) {
        case firstPriceLevel:{
            selectedProduct = self.products[0];
        } break;
        case secondPriceLevel:{
            selectedProduct = self.products[1];
        } break;
        case thirdPriceLevel:{
            selectedProduct = self.products[2];
        } break;
    }
    SKPayment *payment = [SKPayment paymentWithProduct:selectedProduct];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)setDefaultConfiguration
{
    [CCAppearanceConfigurator setDefaultButtonsAppearance];
    [CCAppearanceConfigurator setDefaultTextFieldsAppearance];
}

- (void)setCustomConfiguration
{
    [CCAppearanceConfigurator configurateButtons];
    [CCAppearanceConfigurator configurateTextFields];
}

- (void)paymentSuccessfulyFinised:(NSDictionary *)info
{
    [SVProgressHUD showSuccessWithStatus:@"Payment is successfully performed"];
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

- (void)paymentFailed
{
    
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

@end
