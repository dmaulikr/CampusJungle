//
//  CCUserCollegesTableDataSource.m
//  CampusJungle
//
//  Created by Vlad Korzun on 28.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCUserCollegesTableDataSource.h"

@implementation CCUserCollegesTableDataSource 

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0){
        return self.colleges.count;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
        return [UITableViewCell new];
    } else {
        return [UITableViewCell new];
    }

}

@end
