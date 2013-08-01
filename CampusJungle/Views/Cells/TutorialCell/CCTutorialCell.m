//
//  CCTutorialCell.m
//  CampusJungle
//
//  Created by Vlad Korzun on 01.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCTutorialCell.h"

@interface CCTutorialCell()

@property (nonatomic, strong) IBOutlet UIImageView *imageView;

@end

@implementation CCTutorialCell

- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        self = [[[NSBundle mainBundle] loadNibNamed:@"CCTutorialCell"
                                              owner:self
                                            options:nil] objectAtIndex:0];
    }
    return self;
}

- (void)setCellObject:(id)cellObject
{
    self.imageView.image = cellObject;
}

@end
