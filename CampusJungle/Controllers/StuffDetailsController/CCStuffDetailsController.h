//
//  CCStuffDetailsController.h
//  CampusJungle
//
//  Created by Vlad Korzun on 21.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCBaseViewController.h"
#import "CCStuff.h"
#import "CCTransactionWithObject.h"
#import "CCTransaction.h"

@interface CCStuffDetailsController : CCBaseViewController

@property (nonatomic, strong) CCStuff *stuff;

@property (nonatomic, strong) id<CCTransactionWithObject> photoBrowserTransaction;
@property (nonatomic, strong) id<CCTransactionWithObject> createOfferTarnasaction;
@property (nonatomic, strong) id<CCTransaction> backTransaction;

@end
