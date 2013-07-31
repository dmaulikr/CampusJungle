//
//  CCFilterSectionHeader.m
//  CampusJungle
//
//  Created by Vlad Korzun on 13.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCFilterSectionHeader.h"
#import "CCClass.h"
#import "CCButtonsHelper.h"

static const CGFloat kArrowRotationDuration = 0.3;

@interface CCFilterSectionHeader()

@property (nonatomic, weak) IBOutlet UIImageView *arrowImageView;
@property (nonatomic, weak) IBOutlet UILabel *collegeName;
@property (nonatomic, weak) IBOutlet UIButton *backgroungButton;

@end

@implementation CCFilterSectionHeader

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"CCFilterSectionHeader"
                                              owner:self
                                            options:nil] objectAtIndex:0];
    }
    return self;
}

- (void)setSection:(CCFilterSection *)section
{
    _section = section;
    self.collegeName.text = section.collegeName;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    [self.backgroundView setBackgroundColor:[UIColor brownColor]];
    [CCButtonsHelper removeBackgroundImageInButton:self.backgroungButton];
    [self.backgroungButton setBackgroundImage:[UIImage imageNamed:@"side_menu_section_header"] forState:UIControlStateNormal];
}

- (IBAction)sectionDidPressed
{
    self.section.isOpen = !self.section.isOpen;
    NSArray *indexPathes = [self prepareIndexPathes];
    if(self.section.isOpen){
        [self.table insertRowsAtIndexPaths:indexPathes withRowAnimation:UITableViewRowAnimationAutomatic];
    } else {
        [self.table deleteRowsAtIndexPaths:indexPathes withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    [self performArrowRotation];
}

- (NSArray *)prepareIndexPathes
{
    NSMutableArray *indexPathes = [NSMutableArray new];
    int classCounter = 0;
    for (CCClass *class in self.section.classes){
        NSIndexPath *currentIndexPath = [NSIndexPath indexPathForRow:classCounter++ inSection:self.section.index];
        [indexPathes addObject:currentIndexPath];
    }
    return indexPathes;
}

- (void)performArrowRotation {
    CGFloat rotateDegrees = (self.section.isOpen) ? 0 : -90;
    [UIView animateWithDuration:kArrowRotationDuration animations:^{
        CGAffineTransform transform = CGAffineTransformMakeRotation(rotateDegrees / 180.0 * M_PI);
        [self.arrowImageView setTransform:transform];
    }];
}


@end
