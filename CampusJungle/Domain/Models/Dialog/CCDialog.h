//
//  CCDialog.h
//  CampusJungle
//
//  Created by Vlad Korzun on 16.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCMessage.h"
#import "CCRestKitMappableModel.h"
#import "CCUser.h"

@interface CCDialog : NSObject<CCRestKitMappableModel>

@property (nonatomic, strong) NSString *user1;
@property (nonatomic, strong) NSString *user2;
@property (nonatomic, strong) NSString *groupID;
@property (nonatomic, strong) NSString *dialogID;
@property (nonatomic, strong) CCMessage *lastMessage;
@property (nonatomic, strong) CCUser *interlocutor;


@end
