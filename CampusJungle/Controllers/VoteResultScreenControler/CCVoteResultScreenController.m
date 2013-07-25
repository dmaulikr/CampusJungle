//
//  CCVoteResultScreenController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 25.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCVoteResultScreenController.h"
#import "CCUIImageHelper.h"
@interface CCVoteResultScreenController ()

@property (nonatomic, weak) IBOutlet UIView *progressContainer;

@end

@implementation CCVoteResultScreenController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Vote Results";
    [self drawIndicatorInIndicatorContainer:self.progressContainer withValue:0.2];
}

- (void)drawIndicatorInIndicatorContainer:(UIView *)container withValue:(float)value
{
    UIProgressView *progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    progressView.trackImage =  [[UIImage imageNamed:@"clear"] resizableImageWithCapInsets:UIEdgeInsetsMake(3.0f, 3.0f, 3.0f, 3.0f)];
    progressView.progressImage = [[CCUIImageHelper scaleImageWithName:@"side_menu_section_header" withScale:1.8] resizableImageWithCapInsets:UIEdgeInsetsMake(3.0f, 3.0f, 3.0f, 3.0f)];
    [container addSubview:progressView];
    progressView.frame = container.bounds;
    progressView.progress = value;
}

@end
