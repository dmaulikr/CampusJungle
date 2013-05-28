//
//  CCAuthorizationResponse.h
//  CollegeConnect
//
//  Created by Vlad Korzun on 23.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCUser.h"

@interface CCAuthorizationResponse : NSObject

@property (nonatomic, strong) CCUser *user;
@property (nonatomic) NSString *isFirstLaunch;

@end
