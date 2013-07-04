//
//  CCMarketFilterClassesCell.m
//  CampusJungle
//
//  Created by Vlad Korzun on 14.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCMarketFilterClassesCell.h"
#import "CCClass.h"

@interface CCMarketFilterClassesCell()

@property (nonatomic, strong) IBOutlet UILabel *label;
@property (nonatomic, strong) IBOutlet UIImageView *checkmark;

@end

@implementation CCMarketFilterClassesCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"CCMarketFilterClassesCell" owner:self options:nil][0];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setCellObject:(id)cellObject
{
    _cellObject = cellObject;
    self.label.text = [(CCClass *)cellObject subject];
    [self becomeSelected:[(CCClass *)cellObject isSelected]];
}

- (void)becomeSelected:(BOOL)selected
{
    if(selected){
        self.checkmark.hidden = NO;
        //[self setAccessoryType:UITableViewCellAccessoryCheckmark];
    } else {
        self.checkmark.hidden = YES;
//        [self setAccessoryType:UITableViewCellAccessoryNone];
    }
}

@end
