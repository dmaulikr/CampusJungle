//
//  CCClassTableController.h
//  CampusJungle
//
//  Created by Vlad Korzun on 08.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCTableBasedController.h"
#import "CCCellSelectionProtocol.h"

@interface CCClassTableController : CCTableBasedController

@property (nonatomic, strong) NSString *classID;
@property (nonatomic, weak) UIView *tableHeaderView;

@property (nonatomic, weak) id<CCCellSelectionProtocol> delegate;

@end
