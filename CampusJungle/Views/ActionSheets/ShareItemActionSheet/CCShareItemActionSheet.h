//
//  CCShareItemActionSheet.h
//  CampusJungle
//
//  Created by Yury Grinenko on 11.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCShareItemActionSheet : UIViewController

- (id)initWithTitle:(NSString *)title buttonsArray:(NSArray *)buttonsArray;
- (void)setButtonsArray:(NSArray *)buttonsArray;

- (void)show;
- (void)dismiss;

@end
