//
//  CCGroupCell.h
//  CampusJungle
//
//  Created by Yury Grinenko on 12.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCBaseCell.h"

@class CCGroup;

@protocol CCGroupCellDelegate <NSObject>

- (void)deleteGroup:(CCGroup *)group;

@end

@interface CCGroupCell : CCBaseCell

@property (nonatomic, strong) CCGroup *cellObject;

- (void)setDelegate:(id<CCGroupCellDelegate>)delegate;

@end
