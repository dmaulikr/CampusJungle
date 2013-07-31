//
//  CCGroupMessagePushProcessingBehaviour.h
//  CampusJungle
//
//  Created by Yury Grinenko on 30.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCPushProcessingProtocol.h"
#import "CCPrivateMessageProcessingBehaviour.h"

@interface CCGroupMessagePushProcessingBehaviour : CCPrivateMessageProcessingBehaviour <CCPushProcessingProtocol>

@end
