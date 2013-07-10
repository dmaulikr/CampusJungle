//
//  CCLocationCell.m
//  CampusJungle
//
//  Created by Yury Grinenko on 09.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCLocationCell.h"
#import "CCLocation.h"

@implementation CCLocationCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setCellObject:(id)cellObject
{
    [self setSelectionColor];
    _cellObject = cellObject;
    CCLocation *location = cellObject;
    [self.textLabel setText:location.name];
}
@end
