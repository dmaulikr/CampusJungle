//
//  CCNoteUploadInfo.m
//  CampusJungle
//
//  Created by Vlad Korzun on 07.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCNoteUploadInfo.h"

@implementation CCNoteUploadInfo

- (void)setUploadProgress:(NSNumber *)uploadProgress
{
    _uploadProgress = uploadProgress;
    [self.delegate uploadProgressDidUpdate];
}

- (NSString *)description
{
    return self.noteDescription;
}

@end
