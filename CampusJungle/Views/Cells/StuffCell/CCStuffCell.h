//
//  CCStuffCell.h
//  CampusJungle
//
//  Created by Vlad Korzun on 05.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCBaseCell.h"
#import "CCTableCellProtocol.h"


@interface CCStuffCell : CCBaseCell<CCTableCellProtocol>

@property (nonatomic, strong) id cellObject;

@end
