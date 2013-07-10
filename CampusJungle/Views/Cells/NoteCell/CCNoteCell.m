//
//  CCNoteCell.m
//  CampusJungle
//
//  Created by Vlad Korzun on 6/8/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCNoteCell.h"
#import "CCNote.h"
#import "CCDefines.h"
#import "AFNetworking.h"
#import "MACircleProgressIndicator.h"
#import "CCNoteUploadInfo.h"
#import "CCUploadIndicatorDelegateProtocol.h"

@interface CCNoteCell()<CCUploadIndicatorDelegateProtocol>

@property (nonatomic, weak) IBOutlet UILabel *noteDescription;
@property (nonatomic, weak) IBOutlet UIImageView *thumbImage;
@property (nonatomic, weak) IBOutlet MACircleProgressIndicator *indicator;

@end

@implementation CCNoteCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class])
                                              owner:self
                                            options:nil] objectAtIndex:0];
        [self setSelectionColor];
    }
    return self;
}

- (void)setCellObject:(id)cellObject
{

    
    if([cellObject isKindOfClass:[CCNoteUploadInfo class]]){
        [self setUpUploadingIndicatorWithObject:cellObject];
    } else {
        [self removeIndicator];
    }
    _cellObject = cellObject;
    CCNote *note = (CCNote *)cellObject;
   
    self.noteDescription.text = note.description;
    if(note.thumbnailRetina.length){
        NSString *thumbURL = [NSString stringWithFormat:@"%@%@",CCAPIDefines.baseURL,note.thumbnailRetina];
        [self.thumbImage setImageWithURL:[NSURL URLWithString:thumbURL]];
    } else {
        self.thumbImage.image = [UIImage imageNamed:@"note_placeholder_icon_active"];
    }
}

- (void)setUpUploadingIndicatorWithObject:(CCNoteUploadInfo *)object
{
    self.indicator.color = [UIColor brownColor];
    if([_cellObject  isKindOfClass:[CCNoteUploadInfo class]]){
        [(CCNoteUploadInfo *)_cellObject setDelegate:nil];
    }
    object.delegate = self;
    self.indicator.value = object.uploadProgress.floatValue;
    self.indicator.hidden = NO;
}

- (void)uploadProgressDidUpdate
{
    self.indicator.value = [(CCNoteUploadInfo *)self.cellObject uploadProgress].floatValue;
}

- (void)removeIndicator
{
    self.indicator.hidden = YES;
}

@end
