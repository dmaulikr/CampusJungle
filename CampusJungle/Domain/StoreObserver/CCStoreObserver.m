//
//  CCStoreObserver.m
//  CampusJungle
//
//  Created by Vlad Korzun on 31.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCStoreObserver.h"
#import "CCPaymentServiceProtocol.h"

@interface CCStoreObserver()

@property (nonatomic, strong) id <CCPaymentServiceProtocol> ioc_paymentManager;

@end

@implementation CCStoreObserver

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction *transaction in transactions)
    {
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchased:
                [self completeTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                [self failedTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:
                {
            
                }
            default:
                break;
        }
    }
}

- (void)failedTransaction:(SKPaymentTransaction *)transaction
{
    if (transaction.error.code != SKErrorPaymentCancelled) {
        
    }
    [self.delegate paymentFailed];
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}

- (void)completeTransaction:(SKPaymentTransaction *)transaction
{
    NSDictionary *transactionInfo = @{
                                      @"transactionIdentifier" : transaction.transactionIdentifier,
                                          @"productIdentifier" : transaction.payment.productIdentifier,
                                          @"transactionReceipt" : transaction.transactionReceipt,
                                      };
    [self.delegate paymentSuccessfulyFinised:transactionInfo];
    [self.ioc_paymentManager addInAppPurchasePayment:transactionInfo];
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}

@end
