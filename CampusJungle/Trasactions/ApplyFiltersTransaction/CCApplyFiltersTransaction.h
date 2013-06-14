//
//  CCApplyFiltersTransaction.h
//  CampusJungle
//
//  Created by Vlad Korzun on 14.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCMarketPlaceController.h"
#import "CCTransactionWithObject.h"

@interface CCApplyFiltersTransaction : NSObject<CCTransactionWithObject>

@property (nonatomic, strong) UINavigationController *navigation;
@property (nonatomic, strong) CCMarketPlaceController *marketPlace;

@end
