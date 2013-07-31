//
//  CCStuff.h
//  CampusJungle
//
//  Created by Vlad Korzun on 20.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCRestKitMappableModel.h"
#import "CCModelIdAccessorProtocol.h"

@interface CCStuff : NSObject <CCRestKitMappableModel, CCModelIdAccessorProtocol>

@property (nonatomic, strong) NSString *collegeID;
@property (nonatomic, strong) NSString *stuffID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *stuffDescription;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, strong) NSString *thumbnail;
@property (nonatomic, strong) NSString *thumbnailRetina;
@property (nonatomic, strong) NSArray *photos;
@property (nonatomic, strong) NSString *ownerID;
@property (nonatomic, strong) NSArray *tags;

@end
