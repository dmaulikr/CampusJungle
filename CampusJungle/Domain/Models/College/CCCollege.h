//
//  CCCollege.h
//  CampusJungle
//
//  Created by Vlad Korzun on 29.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCRestKitMappableModel.h"

@interface CCCollege : NSObject <CCRestKitMappableModel>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *collegeID;
@property (nonatomic, strong) NSString *address;

@end
