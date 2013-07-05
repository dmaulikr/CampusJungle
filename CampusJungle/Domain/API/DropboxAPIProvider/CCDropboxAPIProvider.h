//
//  CCDropboxDelegate.h
//  CampusJungle
//
//  Created by Vlad Korzun on 04.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCDropboxAPIProviderProtocol.h"
#import <DropboxSDK/DropboxSDK.h>

@interface CCDropboxAPIProvider : NSObject <CCDropboxAPIProviderProtocol,DBNetworkRequestDelegate,DBSessionDelegate>

@end
