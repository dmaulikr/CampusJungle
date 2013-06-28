//
//  CCMenuCell.m
//  CampusJungle
//
//  Created by Vlad Korzun on 29.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCMenuCell.h"
#import "CCMenuDefines.h"

@interface CCMenuCell()

@property (nonatomic, weak) IBOutlet UILabel *label;
@property (nonatomic, weak) IBOutlet UIImageView *image;

@end

@implementation CCMenuCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"CCMenuCell" owner:self options:nil][0];
    }
    return self;
}

- (void)setCellObject:(id)cellObject
{
    _cellObject = cellObject;
    self.label.text = [(NSString *)cellObject description];
    if([(NSString *)cellObject isEqualToString:CCSideMenuTitles.market]){
        self.image.image = [UIImage imageNamed:@"marketPlaceLogo"];
    }
}

@end
