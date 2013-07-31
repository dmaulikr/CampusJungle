//
//  CCGroup.h
//  CampusJungle
//
//  Created by Yury Grinenko on 11.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCRestKitMappableModel.h"
#import "CCModelIdAccessorProtocol.h"

@interface CCGroup : NSObject <CCRestKitMappableModel, CCModelIdAccessorProtocol>

@property (nonatomic, strong) NSString *groupId;
@property (nonatomic, strong) NSString *classId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *ownerId;
@property (nonatomic, strong) NSString *ownerFirstName;
@property (nonatomic, strong) NSString *ownerLastName;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, assign) NSInteger membersCount;
@property (nonatomic, strong) NSArray *locations;
@property (nonatomic, strong) NSArray *usersIds;
@property (nonatomic, strong) UIImage *selectedLogo;

@property (nonatomic, assign) BOOL isSelected;

+ (CCGroup *)createWithName:(NSString *)name description:(NSString *)description;

@end
