//
//  CCShareItemButton.h
//  CampusJungle
//
//  Created by Yury Grinenko on 11.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCTransactionWithObject.h"

//typedef NSArray *(^ShareItemButtonSuccessBlock)();
//typedef void(^ShareItemButtonCancelBlock)();
typedef void(^ShareItemButtonActionBlock)();

@interface CCShareItemButton : UIButton

+ (CCShareItemButton *)buttonWithTitle:(NSString *)title actionBlock:(ShareItemButtonActionBlock)actionBlock;

@end
