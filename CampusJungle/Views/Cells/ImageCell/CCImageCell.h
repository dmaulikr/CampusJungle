//
//  CCImageCell.h
//  CampusJungle
//
//  Created by Vlad Korzun on 10.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCTableCellProtocol.h"
#import "CCBaseCell.h"

@interface CCImageCell : CCBaseCell<CCTableCellProtocol>

@property (nonatomic, strong) id cellObject;

@end
