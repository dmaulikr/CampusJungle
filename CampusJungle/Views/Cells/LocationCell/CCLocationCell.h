//
//  CCLocationCell.h
//  CampusJungle
//
//  Created by Yury Grinenko on 09.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCBaseCell.h"
@class CCLocation;

@interface CCLocationCell : CCBaseCell

@property (nonatomic, strong) CCLocation *cellObject;

+ (CGFloat)heightForCellWithLocation:(CCLocation *)location;

@end
