//
//  CCOtherUserProfileController.h
//  CampusJungle
//
//  Created by Vlad Korzun on 05.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCViewController.h"
#import "CCUser.h"
#import "CCTransactionWithObject.h"

@interface CCOtherUserProfileController : CCViewController

@property (nonatomic, strong) CCUser *currentUser;
@property (nonatomic, strong) id <CCTransactionWithObject> sendMessageTransaction;

@end
