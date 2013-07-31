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

#import "CCReport.h"

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

+ (void)postReportWithText:(NSString *)text onContent:(id)item
{
    CCReport *report = [CCReport createWithText:text itemId:@"" itemType:NSStringFromClass([item class])];
    CCReportPostingService *reportService = [[CCReportPostingService alloc] initWithReport:report];
}

- (void)postReportIfAvailable:(CCReport *)report
{
    
}

@end
