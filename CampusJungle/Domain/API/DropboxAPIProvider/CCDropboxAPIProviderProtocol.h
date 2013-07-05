//
//  CCDropboxAPIProvider.h
//  CampusJungle
//
//  Created by Vlad Korzun on 04.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTypesDefinition.h"

@protocol CCDropboxAPIProviderProtocol <AppleGuiceSingleton,AppleGuiceInjectable>

- (void)createSession;

- (void)linkWithController:(UIViewController *)controller;

- (void)unlink;

- (BOOL)isLinked;

- (void)loadMetadataForPath:(NSString *)path successHandler:(successWithObject)successHandler errorHanler:(errorHandler)errorHanler;

- (void)loadThumbnailForPath:(NSString *)path successHandler:(successWithObject)successHandler errorHanler:(errorHandler)errorHanler;

- (void)loadDirectURLforPath:(NSString *)path successHandler:(successWithObject)successHandler errorHanler:(errorHandler)errorHanler;

- (void)createRestCliet;

- (void)checkAllDirectURLForArray:(NSArray *)arrayOfMetadata successHandler:(successWithObject)successHandler;

@end