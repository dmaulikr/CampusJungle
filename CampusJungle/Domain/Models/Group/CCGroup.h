//
//  CCGroup.h
//  CampusJungle
//
//  Created by Yury Grinenko on 11.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCRestKitMappableModel.h"

@interface CCGroup : NSObject <CCRestKitMappableModel>

@property (nonatomic, strong) NSString *groupId;
@property (nonatomic, strong) NSString *classId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *ownerId;
@property (nonatomic, strong) NSString *image;

@property (nonatomic, strong) NSArray *members;
@property (nonatomic, strong) NSArray *locations;

@property (nonatomic, assign) BOOL isSelected;

@end
