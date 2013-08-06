//
//  CCClassCell.m
//  CampusJungle
//
//  Created by Yury Grinenko on 06.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCClassCell.h"
#import "CCClass.h"

static const CGFloat kDefaultCellHeight = 80.0;

@interface CCClassCell ()

@property (nonatomic, weak) IBOutlet UILabel *classNumberLabel;
@property (nonatomic, weak) IBOutlet UILabel *classNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *classProfessorLabel;

@property (nonatomic, strong) CCClass *classObject;

@end

@implementation CCClassCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setSelectionColor];
}

- (void)setCellObject:(CCClass *)classObject
{
    _classObject = classObject;
    [self fillLabels];
}

- (void)fillLabels
{
    [self.classNumberLabel setText:self.classObject.callNumber];
    [self.classNameLabel setText:self.classObject.name];
    [self.classProfessorLabel setText:[NSString stringWithFormat:@"Prof. %@", self.classObject.professor]];
}

+ (CGFloat)heightForCellWithObject:(CCClass *)classObject
{
    return kDefaultCellHeight;
}

@end
