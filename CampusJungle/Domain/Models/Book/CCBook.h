//
//  CCBook.h
//  CampusJungle
//
//  Created by Vlad Korzun on 06.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCRestKitMappableModel.h"
#import "CCModelIdAccessorProtocol.h"

@interface CCBook : NSObject <CCRestKitMappableModel, CCModelTypeProtocol>

@property (nonatomic, strong) NSString *collegeID;
@property (nonatomic, strong) NSString *bookID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, strong) NSString *thumbnail;
@property (nonatomic, strong) NSString *thumbnailRetina;
@property (nonatomic, strong) NSString *isbn;
@property (nonatomic, strong) NSArray *photos;
@property (nonatomic, strong) NSString *ownerID;
@property (nonatomic, strong) NSArray *tags;

- (NSNumber *)priceInDolars;

@end
