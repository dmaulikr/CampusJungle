//
//  CCStuffCell.m
//  CampusJungle
//
//  Created by Vlad Korzun on 05.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCStuffCell.h"
#import "CCNote.h"
#import "CCDefines.h"
#import "AFNetworking.h"
#import "MACircleProgressIndicator.h"
#import "CCNoteUploadInfo.h"
#import "CCUploadIndicatorDelegateProtocol.h"
#import "CCStuffUploadInfo.h"
#import "CCStuff.h"

@interface CCStuffCell()<CCUploadIndicatorDelegateProtocol>

@property (nonatomic, weak) IBOutlet UILabel *noteDescription;
@property (nonatomic, weak) IBOutlet UIImageView *thumbImage;
@property (nonatomic, weak) IBOutlet MACircleProgressIndicator *indicator;

@end

@implementation CCStuffCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"CCStuffCell"
                                              owner:self
                                            options:nil] objectAtIndex:0];
        [self setSelectionColor];
    }
    return self;
}

- (void)setCellObject:(id)cellObject
{
    if([cellObject isKindOfClass:[CCStuffUploadInfo class]]){
        [self setUpUploadingIndicatorWithObject:cellObject];
    } else {
        [self removeIndicator];
    }
    _cellObject = cellObject;
    CCStuff *stuff = cellObject;
    
    self.noteDescription.text = stuff.name;
    if(stuff.thumbnailRetina.length){
        NSString *thumbURL = [NSString stringWithFormat:@"%@%@",CCAPIDefines.baseURL,stuff.thumbnailRetina];
        [self.thumbImage setImageWithURL:[NSURL URLWithString:thumbURL]];
    } else {
        self.thumbImage.image = [UIImage imageNamed:@"stuff_placeholder_icon_active"];
    }
}

- (void)setUpUploadingIndicatorWithObject:(CCNoteUploadInfo *)object
{
    self.indicator.color = [UIColor brownColor];
    if([_cellObject  isKindOfClass:[CCStuffUploadInfo class]]){
        [(CCStuffUploadInfo *)_cellObject setDelegate:nil];
    }
    object.delegate = self;
    self.indicator.value = object.uploadProgress.floatValue;
    self.indicator.hidden = NO;
}

- (void)uploadProgressDidUpdate
{
    if([self.cellObject respondsToSelector:@selector(uploadProgress)]){
        self.indicator.value = [(CCStuffUploadInfo *)self.cellObject uploadProgress].floatValue;
    }
}

- (void)removeIndicator
{
    self.indicator.hidden = YES;
}

+ (CGFloat)heightForCellWithObject:(id)object
{
    return 50.;
}

@end
