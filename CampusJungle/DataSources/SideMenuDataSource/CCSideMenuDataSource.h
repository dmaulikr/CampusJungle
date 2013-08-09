//
//  CCSideMenuDataSource.h
//  CampusJungle
//
//  Created by Yulia Petryshena on 5/29/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

@class CCClass;

@protocol CCSideMenuDelegate <NSObject>

- (void)showNewsFeed;
- (void)showMarketPlace;
- (void)showDetailsOfClass:(CCClass *)classObject;
- (void)addClassToCollegeWithId:(NSString *)collegeId;
- (void)showNotesMarket;
- (void)showBooksMarket;
- (void)showCollegeMarket;

@end

@interface CCSideMenuDataSource : NSObject <UITableViewDataSource, UITableViewDelegate>

- (id)initWithDelegate:(id<CCSideMenuDelegate>)delegate sectionsArray:(NSArray *)sectionsArray;

@end
