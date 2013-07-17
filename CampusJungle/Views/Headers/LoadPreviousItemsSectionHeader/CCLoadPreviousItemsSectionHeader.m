//
//  CCLoadPreviousItemsSectionHeader.m
//  CampusJungle
//
//  Created by Yury Grinenko on 16.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCLoadPreviousItemsSectionHeader.h"

@interface CCLoadPreviousItemsSectionHeader ()

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UIButton *actionButton;

@end

@implementation CCLoadPreviousItemsSectionHeader

- (id)initWithTitle:(NSString *)title target:(id)target action:(SEL)selector;
{
    self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class])
                                          owner:self
                                        options:nil] objectAtIndex:0];
    
    [self.titleLabel setText:title];
    [self.actionButton addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return self;
}

@end
