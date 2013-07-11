//
//  CCBaseCell.h
//  CampusJungle
//
//  Created by Vlad Korzun on 03.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <UIKit/UIKit.h>
#define defaultCellHeight 44.0

@interface CCBaseCell : UITableViewCell

- (void)setSelectionColor;

+ (CGFloat)heightForCellWithObject:(id)object;

@end
