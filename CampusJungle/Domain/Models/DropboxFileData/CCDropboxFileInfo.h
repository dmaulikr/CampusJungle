//
//  CCDropboxFileInfo.h
//  CampusJungle
//
//  Created by Vlad Korzun on 05.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <DropboxSDK/DropboxSDK.h>

@interface CCDropboxFileInfo : NSObject

@property (nonatomic, strong) DBMetadata *fileData;
@property (nonatomic, strong) UIImage *thumb;
@property (nonatomic, strong) NSString *directLink;
@property (nonatomic, strong) NSString *localPath;
@property (nonatomic) BOOL isSelected;

+ (NSArray *)arrayOfDirectLinksFromArrayOfInfo:(NSArray *)arrayOfInfo;

@end
