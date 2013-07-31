//
//  CCCity.h
//  CampusJungle
//
//  Created by Vlad Korzun on 29.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCRestKitMappableModel.h"
#import "CCModelIdAccessorProtocol.h"

@interface CCCity : NSObject <CCRestKitMappableModel, CCModelIdAccessorProtocol>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *cityID;

@end

