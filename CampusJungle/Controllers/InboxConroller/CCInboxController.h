//
//  CCInboxControllerViewController.h
//  CampusJungle
//
//  Created by Vlad Korzun on 25.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCTableBaseViewController.h"
#import "CCTransactionWithObject.h"

@interface CCInboxController : CCTableBaseViewController

@property (nonatomic, strong) id <CCTransactionWithObject> offerDetailsTransaction;
@property (nonatomic, strong) id <CCTransactionWithObject> messageDetailsTransaction;

- (void)selectTabAtIndex:(NSInteger)tabIndex;

@end
