//
//  CCSideMenuClassCell.m
//  CampusJungle
//
//  Created by Yury Grinenko on 04.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCSideMenuClassCell.h"
#import "CCClass.h"

@interface CCSideMenuClassCell ()

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;

@end

@implementation CCSideMenuClassCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setSelectionColor];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] objectAtIndex:0];
    }
    return self;
}

- (void)fillWithObject:(id)object
{
    [self.titleLabel setText:((CCClass *)object).subject];
}

@end
