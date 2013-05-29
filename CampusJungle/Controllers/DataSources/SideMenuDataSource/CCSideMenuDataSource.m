//
//  CCSideMenuDataSource.m
//  CampusJungle
//
//  Created by Yulia Petryshena on 5/29/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCSideMenuDataSource.h"

@implementation CCSideMenuDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     return [UITableViewCell new];
}

@end
