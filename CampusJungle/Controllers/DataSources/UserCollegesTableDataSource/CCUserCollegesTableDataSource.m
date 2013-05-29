//
//  CCUserCollegesTableDataSource.m
//  CampusJungle
//
//  Created by Vlad Korzun on 28.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCUserCollegesTableDataSource.h"

@implementation CCUserCollegesTableDataSource 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.colleges.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [UITableViewCell new];
}

@end
