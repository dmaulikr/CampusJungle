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

static const NSInteger kCellHeight = 145;

@interface CCNoteCell()<CCUploadIndicatorDelegateProtocol>

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *viewPriceLabel;
@property (nonatomic, weak) IBOutlet UILabel *fullPriceLabel;
@property (nonatomic, weak) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, weak) IBOutlet UIImageView *thumbImage;
@property (nonatomic, weak) IBOutlet MACircleProgressIndicator *indicator;

@end

@implementation CCNoteCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setSelectionColor];
}

- (void)setCellObject:(id)cellObject
{
    if ([cellObject isKindOfClass:[CCNoteUploadInfo class]]) {
        [self setUpUploadingIndicatorWithObject:cellObject];
    }
    else {
        [self removeIndicator];
    }
    _cellObject = cellObject;
   
    [self setupLabels];
    [self setupImageView];
}

- (void)setupLabels
{
    CCNote *note = self.cellObject;
    [self.nameLabel setText:note.name];
    [self.descriptionLabel setText:note.description];
    [self.viewPriceLabel setText:[NSString stringWithFormat:@"View-Only Price: %@", note.price]];
    [self.fullPriceLabel setText:[NSString stringWithFormat:@"Full Access Price: %@", note.fullPrice]];
}

- (void)setupImageView
{ 
    CCNote *note = self.cellObject;
    if (note.thumbnailRetina.length) {
        NSString *thumbURL = [NSString stringWithFormat:@"%@%@",CCAPIDefines.baseURL, note.thumbnailRetina];
        [self.thumbImage setImageWithURL:[NSURL URLWithString:thumbURL]];
    }
    else {
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

+ (CGFloat)heightForCellWithObject:(id)object
{
    return kCellHeight;
}

@end
