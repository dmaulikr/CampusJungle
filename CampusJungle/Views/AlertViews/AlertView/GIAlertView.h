//
//  GIAlertView.h
//  CampusJungle
//
//  Created by Vlad Korzun on 02.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GIAlert.h"

@interface GIAlertView : UIView<UIAppearanceContainer>

@property (nonatomic, weak) GIAlert *alertController;

@end
