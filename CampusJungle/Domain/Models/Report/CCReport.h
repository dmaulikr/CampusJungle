//
//  CCReport.h
//  CampusJungle
//
//  Created by Yury Grinenko on 31.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCRestKitMappableModel.h"

@interface CCReport : NSObject <CCRestKitMappableModel>

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *itemId;
@property (nonatomic, strong) NSString *itemType;

+ (CCReport *)createWithItemId:(NSString *)itemId itemType:(NSString *)itemType;

@end
