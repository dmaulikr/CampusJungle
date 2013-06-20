//
//  CCNotesCollectionCell.m
//  CampusJungle
//
//  Created by Vlad Korzun on 13.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCNotesCollectionCell.h"
#import "CCDefines.h"
#import "CCNote.h"

@interface CCNotesCollectionCell()

@property (nonatomic, strong) IBOutlet UIImageView *noteThumb;
@property (nonatomic, strong) IBOutlet UILabel *noteDescription;

@end

@implementation CCNotesCollectionCell

- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        self = [[[NSBundle mainBundle] loadNibNamed:@"CCNotesCollectionCell"
                                          owner:self
                                        options:nil] objectAtIndex:0];
    }
    return self;
}


- (void)setCellObject:(id)cellObject
{
    _cellObject = cellObject;
    CCNote *currentNote = cellObject;
    
    self.noteDescription.text = currentNote.description;
    
    if(currentNote.thumbnailRetina.length){
        NSString *thumbPath = [CCAPIDefines.baseURL stringByAppendingString: currentNote.thumbnailRetina];
        [self.noteThumb setImageWithURL:[NSURL URLWithString:thumbPath]];
    } else {
        self.noteThumb.image = [UIImage imageNamed:@"book"];
    }
}

@end
