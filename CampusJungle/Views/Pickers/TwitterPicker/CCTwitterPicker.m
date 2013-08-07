//
//  CCTwitterPicker.m
//  CampusJungle
//
//  Created by Vlad Korzun on 28.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCTwitterPicker.h"
#import "SHOmniAuthTwitter.h"
#import "UIActionSheet+BlocksKit.h"
#import "NSArray+BlocksKit.h"

@implementation CCTwitterPicker

+ (void)showTwitterAccountSelectionInView:(UIView *)view
                        startLoadingBlock:(action)startLaoding
                  fetchInfoSuccessHandler:(successWithObject)successHandler
                             errorHandler:(errorHandler)errorHandler
{
    [SHOmniAuthTwitter performLoginWithListOfAccounts:^(NSArray *accounts, SHOmniAuthAccountPickerHandler pickAccountBlock) {
        UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:@"Pick twitter account"];
        
        [accounts each:^(id<account> account) {
            [actionSheet addButtonWithTitle:account.username handler:^{
                pickAccountBlock(account);
                startLaoding();
            }];
        }];
        NSString * buttonTitle = nil;
        if(accounts.count > 0)
            buttonTitle = @"Add account";
        else
            buttonTitle = @"Connect with Twitter";
        
        [actionSheet addButtonWithTitle:buttonTitle handler:^{
            pickAccountBlock(nil);
            startLaoding();
        }];
        
        __weak UIActionSheet *weakActionSheet = actionSheet;
        [actionSheet setDestructiveButtonWithTitle:@"Cancel" handler:^{
           [weakActionSheet cancelBlock];
        }];
        
        [actionSheet showInView:view];
        
    } onComplete:^(id<account> account, id response, NSError *error, BOOL isSuccess) {
        
        if (isSuccess){
            successHandler(response);
        } else {
            errorHandler(error);
        }
    }];

}

@end
