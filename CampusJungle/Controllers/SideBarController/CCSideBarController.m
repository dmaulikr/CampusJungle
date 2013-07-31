//
//  CCSideBarController.m
//  CampusJungle
//
//  Created by Yulia Petryshena on 5/28/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCSideBarController.h"
#import "CCButtonsHelper.h"

@interface CCSideBarController()

@property (nonatomic, weak) UIBarButtonItem *leftBarButton;

@end

@implementation CCSideBarController

- (id)init {
    if (self = [super init]) {
        [self addObserver:self forKeyPath:@"state" options:NSKeyValueObservingOptionInitial context:nil];
    }
    return self;
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {

    if ([keyPath isEqualToString:@"state"]) {
       [self.view endEditing:YES];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context]; 
    }
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"%@", [self.leftBarButton customView]);
    
    if (self.blockOnViewDidAppear) {
        self.blockOnViewDidAppear();
        self.blockOnViewDidAppear = nil;
    }
}

- (UIBarButtonItem *)leftButtonForCenterPanel
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage imageNamed:@"menuButton"];
    button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    
    [CCButtonsHelper removeBackgroundImageInButton:button];
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(toggleLeftPanel:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.leftBarButton = barButton;
    return barButton;
}


@end
