//
//  CCPaymentAPIProvider.m
//  CampusJungle
//
//  Created by Vlad Korzun on 31.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCPaymentAPIProvider.h"

@implementation CCPaymentAPIProvider

- (void)successPaymentWithPayPal:(NSDictionary *)paymentInfo userID:(NSString *)userID successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler
{
    [self setAuthorizationToken];
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    NSString *path = [NSString stringWithFormat:CCAPIDefines.payUsingPayPal,userID];
    [objectManager putObject:nil
                        path:path
                  parameters:paymentInfo
                     success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        successHandler(mappingResult);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        errorHandler(error);
    }];
}

- (void)makeCashOutRequestWithAmount:(NSString *)amount onEmail:(NSString *)email successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler
{
    NSDictionary *params = @{
                             @"amount" : amount,
                             @"email" : email,
                             };
    [self setAuthorizationToken];
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
   
    [objectManager postObject:nil
                         path:CCAPIDefines.requestMoney
                   parameters:params success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        successHandler(mappingResult.firstObject);
    }
                      failure:^(RKObjectRequestOperation *operation, NSError *error) {
        errorHandler(error);
    }];
}


- (void)successPaymentWithInAppPurchase:(NSDictionary *)paymentInfo userID:(NSString *)userID successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler
{
    [self setAuthorizationToken];
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    
    NSDictionary *params = @{
                             @"transactionIdentifier" : paymentInfo[@"transactionIdentifier"],
                             @"productIdentifier" : paymentInfo[@"productIdentifier"],
                             };
    NSData *transactionReceipt = paymentInfo[@"transactionReceipt"];
    NSString *path = [NSString stringWithFormat:CCAPIDefines.payUsingInAppPurchases,userID];
    NSMutableURLRequest *request =
    [objectManager multipartFormRequestWithObject:nil
                                           method:RKRequestMethodPUT
                                             path:path
                                       parameters:params
                        constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {
         if(transactionReceipt){
             [formData appendPartWithFileData:transactionReceipt
                                         name:@"transactionReceipt"
                                     fileName:@"transaction"
                                     mimeType:@"application/ogg"];
         }
     }];
    RKObjectRequestOperation *operation =
    [objectManager objectRequestOperationWithRequest:request
                                             success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult)
     {
         if(successHandler){
             successHandler(mappingResult.firstObject);
         }
     }
                                             failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                 if(errorHandler){
                                                     errorHandler(error);
                                                 }
                                             }];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [operation start];
    });
}


@end
