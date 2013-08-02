//
//  CCAnoucementCell.h
//  CampusJungle
//
//  Created by Vlad Korzun on 23.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCBaseCell.h"
#import "CCAnnouncement.h"

@protocol CCAnnouncementCellDelegate <NSObject>

- (void)deleteAnnouncement:(CCAnnouncement *)announcement;

@end

@interface CCAnnouncementCell : CCBaseCell

@property (nonatomic, strong) CCAnnouncement * cellObject;
- (void)setCellObject:(CCAnnouncement *)announcement;
- (void)setDelegate:(id<CCAnnouncementCellDelegate>)delegate;

@end
