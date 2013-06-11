//
//  CCNoteUploadInfo.h
//  CampusJungle
//
//  Created by Vlad Korzun on 07.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCNoteUploadInfo : NSObject

@property (nonatomic, strong) NSNumber *collegeID;
@property (nonatomic, strong) NSString *noteDescription;
@property (nonatomic, strong) NSNumber *classID;
@property (nonatomic, strong) NSArray *tags;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, strong) NSNumber *fullPrice;
@property (nonatomic, strong) UIImage *thumbnail;

@property (nonatomic, strong) NSArray *arrayOfURLs;
@property (nonatomic, strong) NSArray *arrayOfImages;
@property (nonatomic, strong) NSString *pdfUrl;

@end
