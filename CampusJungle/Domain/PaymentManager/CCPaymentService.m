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
    [self setPayPalArray:payments];
    [self sendAllPaypalPayments];
}

- (void)addInAppPurchasePayment:(NSDictionary *)newPayment
{
    NSMutableArray *payments = [self getInAppPurchaseArray];
    [payments addObject:newPayment];
    [self setInAppPurchaseArray:payments];
    [self sendAllInAppPurchasePayments];
}

- (void)sendAllPaypalPayments
{
    for(NSDictionary *savedPayment in [self getPayPalPaymentsArray]){
        [self.ioc_PaymentAPIProvider successPaymentWithPayPal:savedPayment
                                                       userID:[[self.ioc_userSession currentUser] uid]
                                               successHandler:^(id result){
                                                   NSMutableArray *payments = [self getPayPalPaymentsArray];
                                                   for(NSDictionary *payment in payments){
                                                       if([self isPayPalPayment:payment equalTo:savedPayment]){
                                                           [payments removeObject:payment];
                                                       }
                                                   }
                                                   [self setPayPalArray:payments];
                                               }
                                                 errorHandler:^(NSError *error){
                                                     
                                                 }];
    }
}

- (void)sendAllInAppPurchasePayments
{
    for(NSDictionary *savedPayment in [self getInAppPurchaseArray]){
        [self.ioc_PaymentAPIProvider successPaymentWithInAppPurchase:savedPayment
                                                              userID:[[self.ioc_userSession currentUser] uid]
                                                      successHandler:^(id result){
                                                          NSMutableArray *payments = [self getInAppPurchaseArray];
                                                          for(NSDictionary *payment in payments){
                                                              if([self isInAppPurchasePayment:payment equalTo:savedPayment]){
                                                                  [payments removeObject:payment];
                                                              }
                                                          }
                                                          [self setInAppPurchaseArray:payments];
                                                      }
                                                        errorHandler:^(NSError *error){
                                                            
                                                        }];
    }
}

- (void)resendAllPayments
{
    [self sendAllInAppPurchasePayments];
    [self sendAllPaypalPayments];
}

- (BOOL)isPayPalPayment:(NSDictionary *)firstPayment equalTo:(NSDictionary *)secondPayment
{
    return [firstPayment[@"proof_of_payment"][@"adaptive_payment"][@"pay_key"] isEqualToString:secondPayment[@"proof_of_payment"][@"adaptive_payment"][@"pay_key"]];
}

- (BOOL)isInAppPurchasePayment:(NSDictionary *)firstPayment equalTo:(NSDictionary *)secondPayment
{
    return [firstPayment[@"transactionIdentifier"] isEqualToString:secondPayment[@"transactionIdentifier"]];
}

- (NSMutableArray *)getPayPalPaymentsArray
{
    return [self getArrayWithKey:PayPalPayments];
}

- (NSMutableArray *)getInAppPurchaseArray
{
    return [self getArrayWithKey:InAppPurchasePayments];
}

- (NSMutableArray *)getArrayWithKey:(NSString *)key
{
    NSArray *arrayOfPayments = [self.userDefaults arrayForKey:key];
    if (arrayOfPayments){
        return [arrayOfPayments mutableCopy];
    } else {
        return [NSMutableArray new];
    }
}

- (void)setPayPalArray:(NSArray *)array
{
    [self setArray:array withKey:PayPalPayments];
}

- (void)setInAppPurchaseArray:(NSArray *)array
{
    [self setArray:array withKey:InAppPurchasePayments];
}

- (void)setArray:(NSArray *)array withKey:(NSString *)key
{
    [self.userDefaults setObject:array forKey:PayPalPayments];
    [self.userDefaults synchronize];
}

@end
