//
//  CCBaseCell.h
//  CampusJungle
//
//  Created by Vlad Korzun on 03.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCButtonsHelper.h"
#import "CCReportDelegateProtocol.h"
#define defaultCellHeight 44.0

@interface CCBaseCell : UITableViewCell

@property (nonatomic, strong) UIImageView *bottomDivider;

- (void)addBottomDivider;
- (void)setSelectionColor;
+ (CGFloat)heightForCellWithObject:(id)object;

@property (nonatomic, weak) IBOutlet UIView *reportButtonContainer;
@property (nonatomic, strong) UIButton *reportButton;
@property (nonatomic, weak) id <CCReportDelegateProtocol> reportDelegate;

@end
