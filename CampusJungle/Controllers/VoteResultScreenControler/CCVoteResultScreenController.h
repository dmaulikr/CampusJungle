//
//  CCVoteResultScreenController.h
//  CampusJungle
//
//  Created by Vlad Korzun on 25.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCBaseViewController.h"
#import "CCClass.h"
#import "CCTransaction.h"

@interface CCVoteResultScreenController : CCBaseViewController

@property (nonatomic, strong) CCClass *currentClass;
@property (nonatomic, strong) id <CCTransaction> backToClassTransaction;

@end
