//
//  CCOtherUserProfileController.h
//  CampusJungle
//
//  Created by Vlad Korzun on 05.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCBaseViewController.h"
#import "CCUser.h"
#import "CCTableBaseViewController.h"
#import "CCTransactionWithObject.h"

@interface CCOtherUserProfileController : CCTableBaseViewController

@property (nonatomic, strong) CCUser *currentUser;
@property (nonatomic, strong) id <CCTransactionWithObject> sendMessageTransaction;
@property (nonatomic, strong) id <CCTransactionWithObject> classTransaction;

@end
