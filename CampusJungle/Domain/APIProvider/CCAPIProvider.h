//
//  CCAPIProvider.h
//  CollegeConnect
//
//  Created by Vlad Korzun on 21.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAPIProviderProtocol.h"

@interface CCAPIProvider : NSObject<CCAPIProviderProtocol>

- (void)setAuthorizationToken;
- (void)setContentTypeJSON;
@end
