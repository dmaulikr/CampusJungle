//
//  CCRateControllerViewController.h
//  CampusJungle
//
//  Created by Vlad Korzun on 10.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCBaseViewController.h"
#import "CCNote.h"
#import "CCTransaction.h"

@interface CCReviewController : CCBaseViewController

@property (nonatomic, strong) CCNote *note;
@property (nonatomic, strong) id <CCTransaction> backToNoteTransaction;

@end
