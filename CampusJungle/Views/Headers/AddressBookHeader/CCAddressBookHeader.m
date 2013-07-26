//
//  CCAddressBookHeader.m
//  CampusJungle
//
//  Created by Yury Grinenko on 26.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAddressBookHeader.h"

static const NSInteger kDefaultHeight = 20;

@interface CCAddressBookHeader ()

@property (nonatomic, weak) IBOutlet UILabel *letterLabel;

@end

@implementation CCAddressBookHeader

- (id)initWithText:(NSString *)text
{
    self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] objectAtIndex:0];
    [self.letterLabel setText:text];
    return self;
}

+ (CGFloat)height
{
    return kDefaultHeight;
}

@end
