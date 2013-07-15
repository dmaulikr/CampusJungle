//
//  CCForumCell.h
//  CampusJungle
//
//  Created by Yury Grinenko on 15.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCBaseCell.h"

@class CCForum;

@protocol CCForumCellDelegate <NSObject>

- (void)deleteForum:(CCForum *)forum;

@end

@interface CCForumCell : CCBaseCell

@property (nonatomic, strong) CCForum *cellObject;
- (void)setDelegate:(id<CCForumCellDelegate>)delegate;

@end
