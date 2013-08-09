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

- (NSNumber *)priceInDolars
{
    return @(self.price.doubleValue/100);
}

- (NSNumber *)fullPriceInDolars
{
    return @(self.fullPrice.doubleValue/100);
}

@end
