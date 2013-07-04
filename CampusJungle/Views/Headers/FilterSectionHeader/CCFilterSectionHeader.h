//
//  CCFilterSectionHeader.h
//  CampusJungle
//
//  Created by Vlad Korzun on 13.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCFilterSection.h"

@interface CCFilterSectionHeader : UITableViewHeaderFooterView

@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) CCFilterSection *section;

- (IBAction)sectionDidPressed;

@end
