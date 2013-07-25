//
//  CCGroupInviteCell.h
//  CampusJungle
//
//  Created by Yury Grinenko on 24.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCBaseCell.h"

@class CCGroupInvite;

@protocol CCGroupInviteCellDelegate <NSObject>

- (void)acceptGroupInvite:(CCGroupInvite *)groupInvite;
- (void)rejectGroupInvite:(CCGroupInvite *)groupInvite;
- (void)resendGroupInvite:(CCGroupInvite *)groupInvite;
- (void)deleteGroupInvite:(CCGroupInvite *)groupInvite;

@end

@interface CCGroupInviteCell : CCBaseCell

- (void)setCellObject:(CCGroupInvite *)groupInvite;
- (void)setDelegate:(id<CCGroupInviteCellDelegate>)delegate;

@end
