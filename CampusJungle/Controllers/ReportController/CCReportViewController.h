//
//  CCReportViewController.h
//  CampusJungle
//
//  Created by Yury Grinenko on 31.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCBaseViewController.h"
#import "CCTransaction.h"

@class CCReport;

@interface CCReportViewController : CCBaseViewController

@property (nonatomic, strong) id<CCTransaction> backTransaction;

- (void)setReport:(CCReport *)report;

@end
