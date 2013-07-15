//
//  CCRestKitMappableModel.h
//  CampusJungle
//
//  Created by Yury Grinenko on 15.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CCRestKitMappableModel <NSObject>

@required
+ (void)configureMappingWithManager:(RKObjectManager *)objectManager;

@end
