//
//  GIAlert.h
//  GiftIt
//
//  Created by Vlad Korzun on 20.03.13.
//  Copyright (c) 2013 Julia Petryshena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GIAlertButton.h"

@interface GIAlert : UIViewController<ObjectRemovingProtocol>
@property (nonatomic,strong) IBOutlet UILabel* titleLabel;
@property (nonatomic,strong) IBOutlet UITextView* message;
@property (nonatomic,strong) IBOutlet UIImageView* backgroundImage;

+(GIAlert*)alertWithTitle:(NSString*)title message:(NSString*)message buttons:(NSArray*)arrayOfButtons;

- (void)show;
@end
