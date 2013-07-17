//
//  CCCellSelectionProtocol.h
//  CampusJungle
//
//  Created by Vlad Korzun on 13.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CCCellSelectionProtocol <NSObject>

- (void)didSelectedCellWithObject:(id)cellObject;

@optional
- (BOOL)isNeedToLeftSelected;

@end
