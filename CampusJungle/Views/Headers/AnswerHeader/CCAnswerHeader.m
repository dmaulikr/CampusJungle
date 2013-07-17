//
//  CCAnswerHeader.m
//  CampusJungle
//
//  Created by Yury Grinenko on 17.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAnswerHeader.h"
#import "CCViewPositioningHelper.h"

static const NSInteger kBottomSpace = 10;

@interface CCAnswerHeader ()

@property (nonatomic, weak) IBOutlet UILabel *answerTextLabel;
@property (nonatomic, weak) IBOutlet UIImageView *bottomDividerImageView;

@end

@implementation CCAnswerHeader

- (id)initWithAnswerText:(NSString *)answerText bottomDividerVisibile:(BOOL)isVisible
{
    self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class])
                                          owner:self
                                        options:nil] objectAtIndex:0];
    [self setAnswerText:answerText];
    [self setBottomDividerVisible:isVisible];
    return self;
}

- (void)setAnswerText:(NSString *)text
{
    [self.answerTextLabel setText:text];
    [self.answerTextLabel sizeToFit];
    [CCViewPositioningHelper setHeight:[CCViewPositioningHelper bottomOfView:self.answerTextLabel] + kBottomSpace toView:self];
}

- (void)setBottomDividerVisible:(BOOL)visible
{
    [self.bottomDividerImageView setHidden:!visible];
}

@end
