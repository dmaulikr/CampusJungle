//
//  GIInputAlertViewController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 04.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "GIInputAlert.h"

@interface GIInputAlert ()<UITextFieldDelegate>

@property (nonatomic) NSInteger numberOfFields;

@end

@implementation GIInputAlert

+ (GIInputAlert *)alertWithTitle:(NSString *)title numberOfFields:(NSInteger)numberOfFields buttons:(NSArray *)arrayOfButtons
{
    GIInputAlert *inputAlert = [GIInputAlert new];
    inputAlert.numberOfFields = numberOfFields;
    inputAlert.alertTitle = title;
    inputAlert.arrayOfButtons = arrayOfButtons;
    return inputAlert;
}

- (void)viewDidLoad
{
    if(self.numberOfFields == 1) {
        self.secondField.hidden = YES;
        self.firstField.transform = CGAffineTransformMakeTranslation(0, self.firstField.bounds.size.height/2);
        self.firstField.returnKeyType = UIReturnKeyDone;
    }
    [self.firstField setBackground:[[UIImage imageNamed:@"input_field"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)]];
    [self.secondField setBackground:[[UIImage imageNamed:@"input_field"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)]];
}

- (void)setupSizesInView:(UIView *)view
{
    CGSize alertSize = self.view.bounds.size;
    CGSize baseViewSize = view.bounds.size;
    self.view.frame = CGRectMake((baseViewSize.width - alertSize.width)/2, (baseViewSize.height - alertSize.height)/3, alertSize.width, alertSize.height);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(textField == self.secondField || self.numberOfFields == 1){
        for(GIAlertButton *button in self.arrayOfButtons){
            if(!button.isCancel){
                [button performSelector:@selector(buttonDidClick:) withObject:button];
            }
        }
    } else {
        [[self.view viewWithTag:textField.tag+1] becomeFirstResponder];
        return YES;
    }
    return YES;
}

@end
