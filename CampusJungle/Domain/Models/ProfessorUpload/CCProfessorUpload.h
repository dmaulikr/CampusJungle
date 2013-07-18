//
//  CCProfessorUpload.h
//  CampusJungle
//
//  Created by Vlad Korzun on 18.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCUploadIndicatorDelegateProtocol.h"

@interface CCProfessorUpload : NSObject

@property (nonatomic, strong) NSString *uploadID;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *attachment;
@property (nonatomic, strong) NSString *ownerID;
@property (nonatomic, strong) NSString *ownerFirstName;
@property (nonatomic, strong) NSString *ownerLastName;
@property (nonatomic, strong) NSString *ownerAvatar;
@property (nonatomic, strong) NSDate *createdDate;

@property (nonatomic, strong) NSNumber *uploadProgress;
@property (nonatomic, strong) NSArray *arrayOfImageUrls;
@property (nonatomic, strong) NSArray *arrayOfImages;
@property (nonatomic, strong) NSString *pdfUrl;
@property (nonatomic, weak) id<CCUploadIndicatorDelegateProtocol> delegate;

@end
