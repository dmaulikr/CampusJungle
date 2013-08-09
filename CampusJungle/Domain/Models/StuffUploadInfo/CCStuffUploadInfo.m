//
//  CCStuffUploadInfo.m
//  CampusJungle
//
//  Created by Vlad Korzun on 20.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCStuffUploadInfo.h"

@implementation CCStuffUploadInfo

- (void)setUploadProgress:(NSNumber *)uploadProgress
{
    _uploadProgress = uploadProgress;
    [self.delegate uploadProgressDidUpdate];
}

- (NSString *)description
{
    return self.stuffDescription;
}

- (NSNumber *)priceInDolars
{
    return @(self.price.doubleValue/100);
}

@end
