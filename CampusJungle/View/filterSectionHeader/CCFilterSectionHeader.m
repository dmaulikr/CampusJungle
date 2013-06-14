//
//  CCFilterSectionHeader.m
//  CampusJungle
//
//  Created by Vlad Korzun on 13.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCFilterSectionHeader.h"
#import "CCClass.h"

@interface CCFilterSectionHeader()

@property (nonatomic, weak) IBOutlet UILabel *collegeName;

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
    UIView *background = [[UIView alloc] initWithFrame:self.frame];
    background.backgroundColor = [UIColor grayColor];
    [self setBackgroundView:background];
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

@end
