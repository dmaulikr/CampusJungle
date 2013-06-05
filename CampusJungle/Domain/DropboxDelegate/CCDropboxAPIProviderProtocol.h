//
//  CCDropboxAPIProvider.h
//  CampusJungle
//
//  Created by Vlad Korzun on 04.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CCDropboxAPIProviderProtocol <AppleGuiceSingleton,AppleGuiceInjectable>

- (void)createSession;

- (void)linkWithController:(UIViewController *)controller;

- (void)unlink;

- (BOOL)isLinked;

@end
