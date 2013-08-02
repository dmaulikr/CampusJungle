//
//  CCMessageCell.h
//  CampusJungle
//
//  Created by Vlad Korzun on 11.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCBaseCell.h"

@class CCMessage;

@protocol CCMessageCellDelegate <NSObject>

- (void)deleteMessage:(CCMessage *)message;

@end

@interface CCMessageCell : CCBaseCell
@property (nonatomic, strong) CCMessage *cellObject;
- (void)setCellObject:(CCMessage *)cellObject;
- (void)setDelegate:(id<CCMessageCellDelegate>)delegate;

@end
