//
//  CCBookUploadInfo.h
//  CampusJungle
//
//  Created by Vlad Korzun on 06.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCUploadIndicatorDelegateProtocol.h"


@interface CCBookUploadInfo : NSObject

@property (nonatomic, strong) NSString *collegeID;
@property (nonatomic, strong) NSString *collegeName;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *bookDescription;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, strong) NSString *isbn;
@property (nonatomic, strong) UIImage *thumbnail;
@property (nonatomic, strong) NSArray *arrayOfImages;
@property (nonatomic, strong) NSArray *arrayOfURLs;
@property (nonatomic, strong) NSString *thumbnailRetina;

@property (nonatomic, strong) NSNumber *uploadProgress;
@property (nonatomic, weak) id<CCUploadIndicatorDelegateProtocol> delegate;


@end
