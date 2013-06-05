//
//  CCOrdinaryCell.m
//  CampusJungle
//
//  Created by Yulia Petryshena on 5/30/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCDropboxCell.h"
#import <DropboxSDK/DropboxSDK.h>

@interface CCDropboxCell()

@property (nonatomic, weak) IBOutlet UILabel *fileName;
@property (nonatomic, weak) IBOutlet UIImageView *fileIcon;

@end

@implementation CCDropboxCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"CCDropboxCell"
                                              owner:self
                                            options:nil] objectAtIndex:0];
        
    }
    return self;
}

- (void)setCellObject:(id)cellObject
{
    _cellObject = cellObject;
    DBMetadata *metaData = (DBMetadata *)cellObject;
    self.fileName.text = metaData.filename;
}

@end
