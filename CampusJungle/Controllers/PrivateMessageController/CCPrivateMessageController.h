//
//  CCPrivateMessageControllerViewController.h
//  CampusJungle
//
//  Created by Vlad Korzun on 10.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCViewController.h"
#import "CCUser.h"
#import "CCTransaction.h"

@interface CCPrivateMessageController : CCViewController

@property (nonatomic, strong) CCUser *recipient;
@property (nonatomic, strong) id <CCTransaction> successMessageSendTransaction;

@end