//
//  CCUserCollegesTableDataSource.h
//  CampusJungle
//
//  Created by Vlad Korzun on 28.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCUserCollegesTableDataSource : NSObject<UITableViewDataSource>

@property (nonatomic, strong) NSArray* colleges;
@property (nonatomic, strong) id delegate;

@end
