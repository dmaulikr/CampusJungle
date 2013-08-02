//
//  CCAnswerCell.h
//  CampusJungle
//
//  Created by Yury Grinenko on 16.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCBaseCell.h"

@class CCAnswer;
typedef void(^RequestSuccessBlock)();

@protocol CCAnswerCellDelegate <NSObject>

- (void)deleteAnswer:(CCAnswer *)answer;
- (void)likeAnswer:(CCAnswer *)answer successBlock:(RequestSuccessBlock)successBlock;

@end

@interface CCAnswerCell : CCBaseCell

@property (nonatomic, strong) CCAnswer *cellObject;
- (void)setCellObject:(CCAnswer *)answer;
- (void)setDelegate:(id<CCAnswerCellDelegate>)delegate;

@end
