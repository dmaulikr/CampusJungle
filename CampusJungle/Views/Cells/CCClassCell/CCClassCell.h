//
//  CCClassCell.h
//  CampusJungle
//
//  Created by Yulia Petryshena on 6/4/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCTableCellProtocol.h"

@interface CCClassCell : UITableViewCell<CCTableCellProtocol>

@property (nonatomic, strong) id cellObject;

@end
