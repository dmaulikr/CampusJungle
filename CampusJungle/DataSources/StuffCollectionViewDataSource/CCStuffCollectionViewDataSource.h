//
//  CCStuffCollectionViewDataSource.h
//  CampusJungle
//
//  Created by Yury Grinenko on 25.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCCommonCollectionDataSource.h"

@class CCStuff;
@protocol CCStuffHeaderDelegate;

@interface CCStuffCollectionViewDataSource : CCCommonCollectionDataSource

- (void)setStuff:(CCStuff *)stuff;
- (void)setStuffHeaderDelegate:(id<CCStuffHeaderDelegate>)delegate;

@end
