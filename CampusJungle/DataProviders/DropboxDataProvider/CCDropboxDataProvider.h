//
//  CCDropboxDataProvider.h
//  CampusJungle
//
//  Created by Vlad Korzun on 04.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCBaseDataProvider.h"
#import "CCTypesDefinition.h"

@interface CCDropboxDataProvider : CCBaseDataProvider

@property (nonatomic, strong) NSString *dropboxPath;
@property (nonatomic, copy) action providerDidFinishLoading;
@property (nonatomic, strong) NSMutableArray *arrayOfSelectedItems;

@end
