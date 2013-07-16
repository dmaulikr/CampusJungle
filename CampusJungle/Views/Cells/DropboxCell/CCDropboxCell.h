//
//  CCDropboxCell.h
//  CampusJungle
//
//  Created by Vlad Korzun on 5/30/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCTableCellProtocol.h"
#import "CCBaseCell.h"

@interface CCDropboxCell : CCBaseCell<CCTableCellProtocol>

@property (nonatomic, strong) id cellObject;

- (void)becomeSelected:(BOOL)selected;

@end
