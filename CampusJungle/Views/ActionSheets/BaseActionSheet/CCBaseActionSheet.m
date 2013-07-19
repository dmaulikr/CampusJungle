//
//  CCBaseActionSheet.m
//  CampusJungle
//
//  Created by Yury Grinenko on 19.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCBaseActionSheet.h"

#import "CCViewPositioningHelper.h"

static const CGFloat kAnimationDuration = 0.3;
static const CGFloat kButtonHeight = 38.0;
static const CGFloat kHorizontalIndent = 25.0;
static const CGFloat kVerticalIndent = 10.0;

@interface CCBaseActionSheet ()

@property (nonatomic, strong) IBOutlet UILabel *sheetTitleLabel;
@property (nonatomic, strong) IBOutlet UIView *buttonsContainerView;
@property (nonatomic, strong) IBOutlet UIImageView *backgroundImageView;

@property (nonatomic, strong) UIView *screenBlockingView;
@property (nonatomic, strong) NSString *titleString;
@property (nonatomic, strong) NSArray *buttonsArray;

@end

@implementation CCBaseActionSheet

- (id)initWithTitle:(NSString *)title buttonsArray:(NSArray *)buttonsArray
{
    self = [super init];
    if (self) {
        [self setTitleString:title];
        [self setButtonsArray:buttonsArray];
    }
    return self;
}

#pragma mark -
#pragma mark Actions
- (void)show
{
    [self addScreenBlockingView];
    [[self keyWindow] addSubview:self.view];
    [self.sheetTitleLabel setText:self.titleString];
    [self layoutButtons];
    [self calculateSelfSize];
    [self makeAppearAnimation];
}

- (void)dismiss
{
    [self makeDisappearAnimation];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kAnimationDuration * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.view removeFromSuperview];
        [self.screenBlockingView removeFromSuperview];
        self.buttonsArray = nil;
    });
}

- (void)addScreenBlockingView
{
    UIWindow *keyWindow = [self keyWindow];
    self.screenBlockingView = [[UIView alloc] initWithFrame:keyWindow.bounds];
    self.screenBlockingView.backgroundColor = [UIColor blackColor];
    self.screenBlockingView.alpha = 0;
    [keyWindow addSubview:self.screenBlockingView];
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [self.screenBlockingView addGestureRecognizer:recognizer];
}

- (void)calculateSelfSize
{
    CGSize actionSheetSize = self.view.bounds.size;
    CGFloat newHight = actionSheetSize.height + self.buttonsContainerView.bounds.size.height;
    
    CGSize baseViewSize = [UIApplication sharedApplication].keyWindow.bounds.size;
    
    self.view.frame = CGRectMake(0, baseViewSize.height - newHight, actionSheetSize.width, newHight);
    self.backgroundImageView.frame = self.view.bounds;
}

- (void)layoutButtons
{
    int numberOfButtons = self.buttonsArray.count;
    CGFloat totalWidth = self.buttonsContainerView.bounds.size.width;
    CGFloat lastButtonBottom = 0;
    for(int i = 0; i<numberOfButtons; i++){
        UIButton *button = [self.buttonsArray objectAtIndex:i];
        button.frame = CGRectMake(kHorizontalIndent, i * (kButtonHeight + kVerticalIndent) + kVerticalIndent,totalWidth - 2 * kHorizontalIndent , kButtonHeight);
        [self.buttonsContainerView addSubview:button];
        lastButtonBottom = button.frame.origin.y + button.frame.size.height;
    }
    [CCViewPositioningHelper setHeight:lastButtonBottom + kVerticalIndent toView:self.buttonsContainerView];
}

- (UIWindow *)keyWindow
{
    return [UIApplication sharedApplication].keyWindow;
}

#pragma mark -
#pragma mark Animations
- (void)makeAppearAnimation
{
    self.view.transform = CGAffineTransformMakeTranslation(0, self.view.bounds.size.height);
    [UIView animateWithDuration:kAnimationDuration animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, 0);
        self.screenBlockingView.alpha = 0.5;
    }];
}

- (void)makeDisappearAnimation
{
    [UIView animateWithDuration:kAnimationDuration animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, self.view.bounds.size.height);
        self.screenBlockingView.alpha = 0.0;
    }];
}

@end
