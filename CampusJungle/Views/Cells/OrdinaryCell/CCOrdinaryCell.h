//
//  CCOrdinaryCell.h
//  CampusJungle
//
//  Created by Yulia Petryshena on 5/30/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCTableCellProtocol.h"
#import "CCBaseCell.h"

@interface CCOrdinaryCell : CCBaseCell <CCTableCellProtocol>

@property (nonatomic, strong) id cellObject;

@end
