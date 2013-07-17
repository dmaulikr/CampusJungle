//
//  CCQuestion.h
//  CampusJungle
//
//  Created by Yury Grinenko on 15.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCRestKitMappableModel.h"
#import "CCUploadIndicatorDelegateProtocol.h"

@interface CCQuestion : NSObject <CCRestKitMappableModel>

@property (nonatomic, strong) NSString *questionId;
@property (nonatomic, strong) NSString *forumId;
@property (nonatomic, strong) NSString *ownerId;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *attachment;
@property (nonatomic, strong) NSDate *createdDate;
@property (nonatomic, assign) NSInteger answersCount;

@property (nonatomic, strong) NSString *ownerFirstName;
@property (nonatomic, strong) NSString *ownerLastName;
@property (nonatomic, strong) NSString *ownerAvatar;

@property (nonatomic, strong) NSNumber *uploadProgress;
@property (nonatomic, strong) NSArray *arrayOfImageUrls;
@property (nonatomic, strong) NSArray *arrayOfImages;
@property (nonatomic, strong) NSString *pdfUrl;
@property (nonatomic, weak) id<CCUploadIndicatorDelegateProtocol> delegate;

+ (NSDictionary *)responseMappingDictionary;
+ (NSDictionary *)requestMappingDictionary;

@end
