//
//  CCMenuControllerViewController.m
//  CollegeConnect
//
//  Created by Vlad Korzun on 21.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCSideMenuController.h"
#import "CCSideMenuDataSource.h"

@interface CCSideMenuController () <UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableMenu;
@property (nonatomic, strong) CCSideMenuDataSource *dataSource;

@end

@implementation CCSideMenuController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableMenu.delegate = self;
    self.dataSource = [CCSideMenuDataSource new];
    self.tableMenu.dataSource = self.dataSource;
}

- (NSIndexPath *)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.classTransaction perform];
    return indexPath;
}

@end