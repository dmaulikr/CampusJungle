//
//  CCSideMenuDataSource.h
//  CampusJungle
//
//  Created by Yulia Petryshena on 5/29/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

@protocol CCSideMenuDelegate <NSObject>

@end

@interface CCSideMenuDataSource : NSObject <UITableViewDataSource, UITableViewDelegate>

- (id)initWithDelegate:(id<CCSideMenuDelegate>)delegate sectionsArray:(NSArray *)sectionsArray;
//- (void)setSectionsArray:(NSArray *)sectionsArray;

@end
