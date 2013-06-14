//
//  CCMarketFilterDataSource.h
//  CampusJungle
//
//  Created by Vlad Korzun on 13.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCBaseDataProvider.h"
#import "CCCellSelectionProtocol.h"

@interface CCMarketFilterDataSource : NSObject<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) CCBaseDataProvider *dataProvider;
@property (nonatomic, strong) id<CCCellSelectionProtocol> delegate;

@end
