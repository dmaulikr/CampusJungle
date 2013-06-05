//
//  CCOrdinaryCell.m
//  CampusJungle
//
//  Created by Yulia Petryshena on 5/30/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCDropboxCell.h"
#import <DropboxSDK/DropboxSDK.h>
#import "CCDropboxFileInfo.h"

@interface CCDropboxCell()<DBRestClientDelegate>

@property (nonatomic, weak) IBOutlet UILabel *fileName;
@property (nonatomic, weak) IBOutlet UIImageView *fileIcon;
@property (nonatomic, strong) DBRestClient *restClient;

@end

@implementation CCDropboxCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"CCDropboxCell"
                                              owner:self
                                            options:nil] objectAtIndex:0];
        self.restClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
        self.restClient.delegate = self;
    }
    return self;
}

- (void)setCellObject:(id)cellObject
{
    _cellObject = cellObject;
    CCDropboxFileInfo *fileInfo = (CCDropboxFileInfo *)cellObject;
    self.fileName.text = fileInfo.fileData.filename;
    self.fileIcon.image = fileInfo.thumb;
    
    if(!fileInfo.fileData.isDirectory && !fileInfo.directLink){
        [self.restClient loadStreamableURLForFile:fileInfo.fileData.path];
    }
    
    if(fileInfo.fileData.thumbnailExists && !fileInfo.thumb){
            [self.restClient loadThumbnail:fileInfo.fileData.path ofSize:@"s" intoPath:[NSTemporaryDirectory() stringByAppendingPathComponent:fileInfo.fileData.filename]];
    }
}

- (void)restClient:(DBRestClient*)restClient loadedStreamableURL:(NSURL*)url forFile:(NSString*)path
{
    CCDropboxFileInfo *fileInfo = (CCDropboxFileInfo *)self.cellObject;
    if([fileInfo.fileData.path isEqualToString:path]){
        [self.cellObject setDirectLink: url.absoluteString];
    }
}


- (void)restClient:(DBRestClient*)restClient loadedThumbnail:(NSString *)destPath metadata:(DBMetadata *)metadata
{
    CCDropboxFileInfo *fileInfo = (CCDropboxFileInfo *)self.cellObject;
    if([fileInfo.fileData.path isEqualToString:metadata.path]){
        [self.cellObject setThumb: [UIImage imageWithContentsOfFile:destPath]];
        self.fileIcon.image = fileInfo.thumb;
    }
 
}


@end
