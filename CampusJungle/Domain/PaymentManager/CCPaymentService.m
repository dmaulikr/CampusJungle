//
//  CCPaymentManager.m
//  CampusJungle
//
//  Created by Vlad Korzun on 31.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#define PayPalPayments @"PayPalPayments"
#define InAppPurchasePayments @"InAppPurchasePayments"

#import "CCPaymentService.h"
#import "CCPaymentAPIProviderProtocol.h"
#import "CCUserSessionProtocol.h"

@interface CCPaymentService()

@property (nonatomic, strong) NSUserDefaults *userDefaults;
@property (nonatomic, strong) id <CCPaymentAPIProviderProtocol> ioc_PaymentAPIProvider;
@property (nonatomic, strong) id <CCUserSessionProtocol> ioc_userSession;

@end

@implementation CCPaymentService

- (id)init
{
    if(self = [super init]){
        self.userDefaults = [NSUserDefaults standardUserDefaults];
    }
    return self;
}

- (void)addPayPalPayment:(NSDictionary *)newPayment
{
    NSMutableArray *payments = [self getPayPalPaymentsArray];
    [payments addObject:newPayment];
    [self.ioc_PaymentAPIProvider successPaymentWithPayPal:newPayment
                                                   userID:[[self.ioc_userSession currentUser] uid]
                                           successHandler:^(id result){
                                               NSMutableArray *payments = [self getPayPalPaymentsArray];
                                               for(NSDictionary *payment in payments){
                                                   if([payment[@"proof_of_payment"][@"adaptive_payment"][@"pay_key"] isEqualToString:newPayment[@"proof_of_payment"][@"adaptive_payment"][@"pay_key"]]){
                                                       [payments removeObject:payment];
                                                   }
                                               }
                                               [self setPayPalArray:payments];
                                           }
                                             errorHandler:^(NSError *error){
                                             
                                             }];
    [self setPayPalArray:payments];
}

- (void)addInAppPurchasePayment:(NSDictionary *)newPayment
{
    NSMutableArray *payments = [self getInAppPurchaseArray];
    [payments addObject:newPayment];
    [self.ioc_PaymentAPIProvider successPaymentWithInAppPurchase:newPayment
                                                   userID:[[self.ioc_userSession currentUser] uid]
                                           successHandler:^(id result){
                                               NSMutableArray *payments = [self getInAppPurchaseArray];
                                               for(NSDictionary *payment in payments){
                                                   if([payment[@"transactionIdentifier"] isEqualToString:newPayment[@"transactionIdentifier"]]){
                                                       [payments removeObject:payment];
                                                   }
                                               }
                                               [self setInAppPurchaseArray:payments];
                                           }
                                             errorHandler:^(NSError *error){
                                                 
                                             }];
    [self setPayPalArray:payments];
}

- (void)resendAllPayments
{
    for(NSDictionary *savedPayment in [self getInAppPurchaseArray]){
        [self.ioc_PaymentAPIProvider successPaymentWithInAppPurchase:savedPayment
                                                   userID:[[self.ioc_userSession currentUser] uid]
                                           successHandler:^(id result){
                                               NSMutableArray *payments = [self getInAppPurchaseArray];
                                               for(NSDictionary *payment in payments){
                                                   if([payment[@"transactionIdentifier"] isEqualToString:savedPayment[@"transactionIdentifier"]]){
                                                       [payments removeObject:payment];
                                                   }
                                               }
                                               [self setInAppPurchaseArray:payments];
                                           }
                                             errorHandler:^(NSError *error){
                                                 
                                             }];
    }
    for(NSDictionary *savedPayment in [self getInAppPurchaseArray]){
        [self.ioc_PaymentAPIProvider successPaymentWithPayPal:savedPayment
                                                              userID:[[self.ioc_userSession currentUser] uid]
                                                      successHandler:^(id result){
                                                          NSMutableArray *payments = [self getPayPalPaymentsArray];
                                                          for(NSDictionary *payment in payments){
                                                              if([payment[@"proof_of_payment"][@"adaptive_payment"][@"pay_key"] isEqualToString:savedPayment[@"proof_of_payment"][@"adaptive_payment"][@"pay_key"]]){
                                                                  [payments removeObject:payment];
                                                              }
                                                          }
                                                          [self setPayPalArray:payments];
                                                      }
                                                        errorHandler:^(NSError *error){
                                                            
                                                        }];
    }
}

- (NSMutableArray *)getPayPalPaymentsArray
{
    return [[self.userDefaults arrayForKey:PayPalPayments] mutableCopy];
}

- (void)setPayPalArray:(NSArray *)array
{
    [self.userDefaults setObject:array forKey:PayPalPayments];
    [self.userDefaults synchronize];
}

- (NSMutableArray *)getInAppPurchaseArray
{
    return [[self.userDefaults arrayForKey:InAppPurchasePayments] mutableCopy];
}

- (void)setInAppPurchaseArray:(NSArray *)array
{
    [self.userDefaults setObject:array forKey:InAppPurchasePayments];
    [self.userDefaults synchronize];
}

@end
