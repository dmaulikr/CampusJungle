//
//  CCReportPostingService.m
//  CampusJungle
//
//  Created by Yury Grinenko on 31.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCReportPostingService.h"
#import "CCReportsApiProviderProtocol.h"
#import "CCTransactionWithObject.h"
#import "CCSendReportTransaction.h"
#import "CCNavigationHelper.h"
#import "CCStandardErrorHandler.h"

#import "CCReport.h"

typedef void(^ReportAvailableSuccessBlock)();

@interface CCReportPostingService ()

@property (nonatomic, strong) id<CCReportsApiProviderProtocol> ioc_reportsApiProvider;
@property (nonatomic, strong) id<CCTransactionWithObject> sendReportTransaction;
@property (nonatomic, strong) CCReport *report;

@end

@implementation CCReportPostingService

- (id)initWithReport:(CCReport *)report;
{
    self = [super init];
    if (self) {
        self.report = report;
        self.sendReportTransaction = [CCSendReportTransaction new];
        [(CCSendReportTransaction *)self.sendReportTransaction setNavigation:[CCNavigationHelper activeNavigationController]];
    }
    return self;
}

+ (void)postReportOnContent:(id<CCModelIdAccessorProtocol>)item
{
    CCReport *report = [CCReport createWithItemId:[item modelId] itemType:NSStringFromClass([item class])];
    CCReportPostingService *reportService = [[CCReportPostingService alloc] initWithReport:report];
    [reportService postReportIfAvailable];
}

- (void)postReportIfAvailable
{
    CCReport *report = self.report;
    id<CCTransactionWithObject> sendReportTransaction = self.sendReportTransaction;
    [self checkIfAvailableReportWithSuccessBlock:^{
        [sendReportTransaction performWithObject:report];
    }];
}

#pragma mark -
#pragma mark Requests
- (void)checkIfAvailableReportWithSuccessBlock:(ReportAvailableSuccessBlock)successBlock
{
    [self.ioc_reportsApiProvider checkIfAvailableReport:self.report successHandler:^(id result) {
        successBlock();
    } errorHandler:^(NSError *error) {
        [CCStandardErrorHandler showErrorWithError:error];
    }];
}

@end
