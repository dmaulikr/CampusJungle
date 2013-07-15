//
//  CCLocationCell.h
//  CampusJungle
//
//  Created by Yury Grinenko on 09.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCBaseCell.h"

@class CCLocation;

@protocol CCLocationCellDelegate <NSObject>

- (void)deleteLocation:(CCLocation *)location;

@end

@interface CCLocationCell : CCBaseCell

@property (nonatomic, strong) CCLocation *cellObject;
- (void)setDelegate:(id<CCLocationCellDelegate>)delegate;

@end
