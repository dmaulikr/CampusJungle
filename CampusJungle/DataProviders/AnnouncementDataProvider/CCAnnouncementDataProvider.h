//
//  CCAnnouncementDataProvider.h
//  CampusJungle
//
//  Created by Vlad Korzun on 22.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCPaginationDataProvider.h"

@interface CCAnnouncementDataProvider : CCPaginationDataProvider

@property (nonatomic, strong) NSString *classID;
@property (nonatomic, strong) id delegate;

@end
