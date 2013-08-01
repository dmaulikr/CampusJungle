//
//  CCSendReportTransaction.m
//  CampusJungle
//
//  Created by Yury Grinenko on 31.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCSendReportTransaction.h"
#import "CCReportViewController.h"
#import "CCBackTransaction.h"

@implementation CCSendReportTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    NSParameterAssert(object);
    
    CCBackTransaction *backTransaction = [CCBackTransaction new];
    backTransaction.navigation = self.navigation;
    
    CCReportViewController *reportController = [CCReportViewController new];
    reportController.backTransaction = backTransaction;
    [reportController setReport:object];
    [self.navigation pushViewController:reportController animated:YES];
}

@end
