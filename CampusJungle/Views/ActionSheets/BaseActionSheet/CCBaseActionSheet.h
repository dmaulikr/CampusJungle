//
//  CCBaseActionSheet.h
//  CampusJungle
//
//  Created by Yury Grinenko on 19.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCBaseActionSheet : UIViewController

- (id)initWithTitle:(NSString *)title buttonsArray:(NSArray *)buttonsArray;
- (void)show;
- (void)dismiss;

@end
