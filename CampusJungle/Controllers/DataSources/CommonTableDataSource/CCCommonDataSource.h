//
//  CCCommonDataSource.h
//  CampusJungle
//
//  Created by Vlad Korzun on 29.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCBaseDataProvider.h"

@protocol CellSelectionProtocol <NSObject>

- (void)didSelectedCellWithObject:(id)cellObject;

@end

@interface CCCommonDataSource : NSObject<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) id <CellSelectionProtocol> delegate;
@property (nonatomic, strong) CCBaseDataProvider *dataProvider;

@end
