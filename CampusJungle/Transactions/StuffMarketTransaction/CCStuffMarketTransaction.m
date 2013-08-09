//
//  CCStuffMarketTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 09.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCStuffMarketTransaction.h"
#import "CCViewMarketStuffListTransaction.h"
#import "CCMarketStuffDataProvider.h"
#import "CCEducation.h"
#import "CCUser.h"
#import "CCBookMarketTransaction.h"
#import "CCUserSessionProtocol.h"
#import "CCMarketBooksDataProvider.h"

@implementation CCStuffMarketTransaction

- (void)perform
{
    UINavigationController *centralNavigation = [[UINavigationController alloc] init];
    self.menuController.centerPanel = centralNavigation;
    CCViewMarketStuffListTransaction *viewStuffListTransaction = [CCViewMarketStuffListTransaction new];
    
    CCMarketStuffDataProvider *marketStuffDataProvider = [CCMarketStuffDataProvider new];
    [self.ioc_userSessionProtocol loadUserEducationsSuccessHandler:^(id educations){
       NSArray *arrayOfColleges = [CCEducation arrayOfCollegesIDFromEducations:[[self.ioc_userSessionProtocol currentUser] educations]];
        NSDictionary *filters = @{
                                  CCMarketFilterConstants.colleges : arrayOfColleges,
                                  CCMarketFilterConstants.classes :@[]
                                  };
        marketStuffDataProvider.filters = filters;
        marketStuffDataProvider.order = @"date";
        [marketStuffDataProvider loadItems];
    }];
    marketStuffDataProvider.order = @"date";
    viewStuffListTransaction.navigation = centralNavigation;
    [viewStuffListTransaction performWithObject:marketStuffDataProvider];
}

@end
