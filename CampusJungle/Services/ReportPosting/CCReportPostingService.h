//
//  CCReportPostingService.h
//  CampusJungle
//
//  Created by Yury Grinenko on 31.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCReportPostingService : NSObject

+ (void)postReportWithText:(NSString *)text onContent:(id)item;

@end
