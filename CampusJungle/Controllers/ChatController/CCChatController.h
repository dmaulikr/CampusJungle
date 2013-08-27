//
//  CCChatController.h
//  CampusJungle
//
//  Created by Vlad Korzun on 12.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "AMBubbleTableViewController.h"
#import "CCDialog.h"
#import "CCTransactionWithObject.h"

@interface CCChatController : AMBubbleTableViewController

@property (nonatomic, strong) CCDialog *dialog;
@property (nonatomic, strong) id <CCTransactionWithObject> otherUserProfileTransaction;

- (void)loadNewMessages;

@end
