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
#import "CCBookUploadInfo.h"

static const NSInteger kCellHeight = 132;

@interface CCStuffCell() <CCUploadIndicatorDelegateProtocol>

@property (nonatomic, weak) IBOutlet UILabel *priceLabel;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, weak) IBOutlet UIImageView *thumbImage;
@property (nonatomic, weak) IBOutlet MACircleProgressIndicator *indicator;

@end

@implementation CCStuffCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setSelectionColor];
}

- (void)setCellObject:(id)cellObject
{
    if ([cellObject isKindOfClass:[CCStuffUploadInfo class]] || [cellObject isKindOfClass:[CCBookUploadInfo class]]) {
        [self setUpUploadingIndicatorWithObject:cellObject];
    }
    else {
        [self removeIndicator];
    }
    
    _cellObject = cellObject;
    
    [self fillLabels];
    [self fillImageView];
}

- (void)fillLabels
{
    CCStuff *stuff = self.cellObject;
    
    [self.descriptionLabel setText:stuff.description];
    [self.nameLabel setText:stuff.name];
    [self.priceLabel setText:[NSString stringWithFormat:@"Price: $%0.2lf", stuff.priceInDolars.doubleValue]];
}

- (void)fillImageView
{
    CCStuff *stuff = self.cellObject;
    if (stuff.thumbnailRetina.length) {
        NSString *thumbURL = [NSString stringWithFormat:@"%@%@", CCAPIDefines.baseURL, stuff.thumbnailRetina];
        [self.thumbImage setImageWithURL:[NSURL URLWithString:thumbURL]];
    }
    else {
        self.thumbImage.image = [UIImage imageNamed:@"stuff_placeholder_icon_active"];
    }
}

- (void)setUpUploadingIndicatorWithObject:(CCNoteUploadInfo *)object
{
    self.indicator.color = [UIColor brownColor];
    if ([_cellObject  isKindOfClass:[CCStuffUploadInfo class]] || [_cellObject isKindOfClass:[CCBookUploadInfo class]]) {
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
    return kCellHeight;
}

@end
