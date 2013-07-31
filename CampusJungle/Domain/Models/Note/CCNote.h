//
//  CCNote.h
//  CampusJungle
//
//  Created by Vlad Korzun on 08.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCRestKitMappableModel.h"
#import "CCModelIdAccessorProtocol.h"

@interface CCNote : NSObject <CCRestKitMappableModel, CCModelTypeProtocol>

@property (nonatomic, strong) NSString *noteID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *ownerID;
@property (nonatomic, strong) NSNumber *collegeID;
@property (nonatomic, strong) NSString *noteDescription;
@property (nonatomic, strong) NSNumber *classID;
@property (nonatomic, strong) NSArray *tags;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, strong) NSNumber *fullPrice;
@property (nonatomic, strong) NSString *thumbnail;
@property (nonatomic, strong) NSString *thumbnailRetina;
@property (nonatomic, strong) NSString *fullAccess;

@property (nonatomic, strong) NSString *link;

+ (NSDictionary *)noteLinkMappingDictionary;

@end
