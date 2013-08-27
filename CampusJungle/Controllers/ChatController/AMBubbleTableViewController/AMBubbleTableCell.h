//
//  AMBubbleTableCell.h
//  BubbleTableDemo
//
//  Created by Andrea Mazzini on 30/06/13.
//  Copyright (c) 2013 Andrea Mazzini. All rights reserved.
//

#import "AMBubbleGlobals.h"

@protocol BubbleCellDelegate <NSObject>

- (void)didSelectCellWithInxex:(NSInteger)index;

@end

@interface AMBubbleTableCell : UITableViewCell

@property (nonatomic) NSInteger index;
- (id)initWithOptions:(NSDictionary*)options reuseIdentifier:(NSString *)reuseIdentifier;
- (void)setupCellWithType:(AMBubbleCellType)type withWidth:(float)width andParams:(NSDictionary*)params;


@property (nonatomic, weak) id <BubbleCellDelegate> delegate;

@end
