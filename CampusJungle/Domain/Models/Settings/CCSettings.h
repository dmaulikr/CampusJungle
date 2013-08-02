//
//  CCSettings.h
//  CampusJungle
//
//  Created by Vlad Korzun on 02.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCRestKitMappableModel.h"

@interface CCSettings : NSObject<CCRestKitMappableModel>

@property (nonatomic, strong) NSNumber *classesNotifications;
@property (nonatomic, strong) NSNumber *forumsNotifications;
@property (nonatomic, strong) NSNumber *messagesNotificaitons;

@end
