//
//  CCAuthorization.h
//  CollegeConnect
//
//  Created by Vlad Korzun on 21.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCAuthorization : NSObject

@property (nonatomic, strong) NSString *provider;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *oauthToken;

@end