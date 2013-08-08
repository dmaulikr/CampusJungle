//
//  CCBookUploadInfo.m
//  CampusJungle
//
//  Created by Vlad Korzun on 06.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCBookUploadInfo.h"

@implementation CCBookUploadInfo

- (void)setUploadProgress:(NSNumber *)uploadProgress
{
    _uploadProgress = uploadProgress;
    [self.delegate uploadProgressDidUpdate];
}

- (NSString *)description
{
    return self.bookDescription;
}

- (NSNumber *)priceInDolars
{
    return @(self.price.doubleValue/100);
}

@end
