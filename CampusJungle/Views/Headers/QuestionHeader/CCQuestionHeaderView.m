//
//  CCQuestionHeaderView.m
//  CampusJungle
//
//  Created by Yury Grinenko on 17.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCQuestionHeaderView.h"
#import "CCViewPositioningHelper.h"

static const NSInteger kBottomSpace = 10;

@interface CCQuestionHeaderView ()

@property (nonatomic, weak) IBOutlet UILabel *questionTextLabel;

@end

@implementation CCQuestionHeaderView

- (id)initWithQuestionText:(NSString *)questionText
{
    self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class])
                                          owner:self
                                        options:nil] objectAtIndex:0];
    [self setQuestionText:questionText];
    return self;
}

- (void)setQuestionText:(NSString *)text
{
    [self.questionTextLabel setText:text];
    [self.questionTextLabel sizeToFit];
    [CCViewPositioningHelper setHeight:[CCViewPositioningHelper bottomOfView:self.questionTextLabel] + kBottomSpace toView:self];
}

@end
