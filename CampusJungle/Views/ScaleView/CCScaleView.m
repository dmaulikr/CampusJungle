//
//  CCScaleView.m
//  CampusJungle
//
//  Created by Vlad Korzun on 26.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCScaleView.h"
#import "CCUIImageHelper.h"

#define ScaleWidth 260
#define TopMargin 19
#define LeftMargin 30
#define DegreeWidth 1
#define DegreeHeight 41

@interface CCScaleView()
@property (nonatomic, weak) IBOutlet UIView *progressContainer;
@property (nonatomic, strong) UIProgressView *progressView;
@end

@implementation CCScaleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"CCScaleView" owner:self options:nil][0];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    int distance = ScaleWidth/(self.arrayOfValues.count - 1);
    UIColor *degreeColor = [UIColor colorWithRed:130./255 green:65./255 blue:0 alpha:1];
    
    for(int i = 0;i < self.arrayOfValues.count; i++){
        UIView *degreeView = [[UIView alloc] initWithFrame:CGRectMake(LeftMargin + distance * i, TopMargin, DegreeWidth, DegreeHeight)];
        degreeView.backgroundColor = degreeColor;
        [self addSubview:degreeView];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, distance, 15)];
        label.center = CGPointMake(LeftMargin + distance * i, TopMargin - 10);
        label.text = self.arrayOfValues[i];
        label.textColor = degreeColor;
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont fontWithName:@"Avenir-MediumOblique" size:14];
        [self addSubview:label];
    }
    
    [self drawIndicatorInIndicatorContainer:self.progressContainer withValue:self.value];
    
}

- (void)drawIndicatorInIndicatorContainer:(UIView *)container withValue:(float)value
{
    self.progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    self.progressView.trackImage =  [[UIImage imageNamed:@"clear"] resizableImageWithCapInsets:UIEdgeInsetsMake(3.0f, 3.0f, 3.0f, 3.0f)];
    self.progressView.progressImage = [[CCUIImageHelper scaleImageWithName:@"side_menu_section_header" withScale:1.8] resizableImageWithCapInsets:UIEdgeInsetsMake(3.0f, 3.0f, 3.0f, 3.0f)];
    [self addSubview:self.progressView];
    self.progressView.frame = CGRectMake(30, 27, 260, 27);
    self.progressView.progress = value;
}

- (void)setValue:(float)value
{
    _value = value;
    
    self.progressView.progress = value;
}

@end
