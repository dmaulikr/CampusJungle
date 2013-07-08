//
//  CCClassTableDataSorce.h
//  CampusJungle
//
//  Created by Yulia Petryshena on 5/29/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCCommonDataSource.h"

@interface CCClassControllerTableDataSource : CCCommonDataSource

@property (nonatomic, strong) UIView *viewForSectionHeader;

@end