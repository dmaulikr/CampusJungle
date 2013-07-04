//
//  GIInputAlertViewController.h
//  CampusJungle
//
//  Created by Vlad Korzun on 04.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "GIAlert.h"

@interface GIInputAlert : GIAlert

@property (nonatomic, weak) IBOutlet UITextField *firstField;
@property (nonatomic, weak) IBOutlet UITextField *secondField;

+(GIInputAlert*)alertWithTitle:(NSString*)title numberOfFields:(NSInteger)numberOfFields buttons:(NSArray*)arrayOfButtons;

@end
