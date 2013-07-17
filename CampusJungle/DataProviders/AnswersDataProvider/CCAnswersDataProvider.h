//
//  CCAnswersDataProvider.h
//  CampusJungle
//
//  Created by Yury Grinenko on 16.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCBaseReverseDataProvider.h"

@interface CCAnswersDataProvider : CCBaseReverseDataProvider

@property (nonatomic, strong) NSString *questionId;

@end
