//
//  CCMessageCell.h
//  CampusJungle
//
//  Created by Vlad Korzun on 11.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCBaseCell.h"
#import "CCDialog.h"


@protocol CCDialogCellDelegate <NSObject>

- (void)deleteDialog:(CCDialog *)dialog;

@end

@interface CCDialogCell : CCBaseCell
@property (nonatomic, strong) CCDialog *cellObject;
- (void)setCellObject:(CCDialog *)cellObject;
- (void)setDelegate:(id<CCDialogCellDelegate>)delegate;

@end
