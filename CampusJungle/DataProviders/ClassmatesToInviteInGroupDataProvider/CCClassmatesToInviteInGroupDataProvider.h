//
//  CCClassmatesToInviteInGroupDataProvider.h
//  CampusJungle
//
//  Created by Yury Grinenko on 24.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCPaginationDataProvider.h"

@class CCGroup;

@interface CCClassmatesToInviteInGroupDataProvider : CCPaginationDataProvider

- (void)setGroup:(CCGroup *)group;

@end
