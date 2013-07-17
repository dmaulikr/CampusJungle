//
//  CCQuestionCell.h
//  CampusJungle
//
//  Created by Yury Grinenko on 15.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCBaseCell.h"

@class CCQuestion;

@protocol CCQuestionCellDelegate <NSObject>

- (void)deleteQuestion:(CCQuestion *)question;
- (void)emailAttachmentOfQuestion:(CCQuestion *)question;
- (void)viewAttachmentOfQuestion:(CCQuestion *)question;

@end

@interface CCQuestionCell : CCBaseCell

- (void)setCellObject:(CCQuestion *)object;
- (void)setDelegate:(id<CCQuestionCellDelegate>)delegate;

@end
