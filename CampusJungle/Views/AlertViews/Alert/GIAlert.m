//
//  GIAlert.m
//  GiftIt
//
//  Created by Vlad Korzun on 20.03.13.
//  Copyright (c) 2013 Julia Petryshena. All rights reserved.
//

#import "GIAlert.h"
#define AnimationDuration 0.3
#define hoizontalInsets 5

@interface GIAlert ()
@property (nonatomic,strong) UIView * blockedView;
@end

@implementation GIAlert

+ (GIAlert *)alertWithTitle:(NSString *)title message:(NSString *)message buttons:(NSArray *)arrayOfButtons
{
    GIAlert * alert = [GIAlert new];
    alert.alertTitle = title;
    alert.alertMesage = message;
    alert.arrayOfButtons = arrayOfButtons;
    return alert;
}

- (void)show
{
    UIView *parentView = [UIApplication sharedApplication].keyWindow;
    [parentView endEditing:YES];
    self.blockedView = [[UIView alloc] initWithFrame:parentView.frame];
    [parentView addSubview:self.blockedView];
    [parentView addSubview:self.view];
    [self prepareButtons];
    [self setupSizesInView:parentView];
    
    self.titleLabel.text = self.alertTitle;
    self.message.text = self.alertMesage;
    
    self.backgroundImage.image = [UIImage imageNamed:@"alert_dialog_shape.png"];
}

- (void)showAnimated
{
    self.view.alpha = 0;
    [UIView animateWithDuration:AnimationDuration animations:^{
        self.view.alpha = 1;
    }];
}

- (void)removeAnimated
{
    [UIView animateWithDuration:AnimationDuration animations:^{
        self.view.alpha = 0;
    }];
}

- (void)setupSizesInView:(UIView *)view
{
    CGSize alertSize = self.view.bounds.size;
    CGSize baseViewSize = view.bounds.size;
    self.view.frame = CGRectMake((baseViewSize.width - alertSize.width)/2, (baseViewSize.height - alertSize.height)/3, alertSize.width, alertSize.height);
}

- (void)remove
{
    [self removeAnimated];
    double delayInSeconds = AnimationDuration;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.view removeFromSuperview];
        self.arrayOfButtons = nil;
        [self.blockedView removeFromSuperview];
        self.blockedView = nil;
    });
}

- (void)prepareButtons
{
    int numberOfButtons = self.arrayOfButtons.count;
    CGFloat totalWidth = self.buttonsContainer.bounds.size.width;
    CGFloat widthPerButton = totalWidth/numberOfButtons;
    for(int i = 0; i<numberOfButtons;i++){
        GIAlertButton * currentButton = self.arrayOfButtons[i];
        currentButton.frame = CGRectMake(i * widthPerButton + hoizontalInsets, 0, widthPerButton - 2 * hoizontalInsets , self.buttonsContainer.frame.size.height);
        
        currentButton.containingObject = self;
        [self.buttonsContainer addSubview:currentButton];
    }
}

@end
