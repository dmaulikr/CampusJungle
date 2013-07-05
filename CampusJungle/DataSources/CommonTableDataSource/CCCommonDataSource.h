//
//  CCCommonDataSource.h
//  CampusJungle
//
//  Created by Vlad Korzun on 29.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCBaseDataProvider.h"
#import "CCCellSelectionProtocol.h"

@interface CCCommonDataSource : NSObject<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) id <CCCellSelectionProtocol> delegate;
@property (nonatomic, strong) CCBaseDataProvider *dataProvider;

@end
