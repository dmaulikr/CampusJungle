//
//  CCMessageDetailsControllerViewController.h
//  CampusJungle
//
//  Created by Vlad Korzun on 12.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCViewController.h"
#import "CCTransactionWithObject.h"
#import "CCMessage.h"

@interface CCMessageDetailsController : CCViewController

@property (nonatomic, strong) id <CCTransactionWithObject> senderDetailsTransaction;
@property (nonatomic, strong) id <CCTransactionWithObject> replyTransaction;
@property (nonatomic, strong) CCMessage *message;

@end
