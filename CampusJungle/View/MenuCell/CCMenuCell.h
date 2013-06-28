//
//  CCMenuCell.h
//  CampusJungle
//
//  Created by Vlad Korzun on 29.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCTableCellProtocol.h"

@interface CCMenuCell : UITableViewCell<CCTableCellProtocol>

@property (nonatomic, strong) id cellObject;

@end
