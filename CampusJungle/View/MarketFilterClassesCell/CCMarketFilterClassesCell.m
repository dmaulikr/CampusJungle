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

@property (nonatomic, strong) UILabel *label;

@end

@implementation CCMarketFilterClassesCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 300, 30)];
        [self addSubview:self.label];
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

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    if(highlighted){
        CCClass *currentClass = self.cellObject;
        
//        if([currentClass.classID isEqualToString:@"0"]){
//            
//        } else {
//            
//        }
        
        currentClass.isSelected = !currentClass.isSelected;
        [self becomeSelected:currentClass.isSelected];
        
    }
}

- (void)becomeSelected:(BOOL)selected
{
    if(selected){
        [self setAccessoryType:UITableViewCellAccessoryCheckmark];
    } else {
        [self setAccessoryType:UITableViewCellAccessoryNone];
    } 
}

@end
