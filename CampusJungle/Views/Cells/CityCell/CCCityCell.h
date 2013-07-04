//
//  CCCityCell.h
//  CampusJungle
//
//  Created by Vlad Korzun on 29.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCTableCellProtocol.h"

@interface CCCityCell : UITableViewCell<CCTableCellProtocol>

@property (nonatomic, strong) id cellObject;

@end
