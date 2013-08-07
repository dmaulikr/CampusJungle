//
//  CCOfferDetailsController.h
//  CampusJungle
//
//  Created by Vlad Korzun on 09.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCBaseViewController.h"
#import "CCOffer.h"
#import "CCTransactionWithObject.h"

@interface CCOfferDetailsController : CCBaseViewController

@property (nonatomic, strong) CCOffer *offer;
@property (nonatomic, strong) id <CCTransactionWithObject> senderDetailsTransaction;
@property (nonatomic, strong) id <CCTransactionWithObject> stuffDetailsTransaction;
@property (nonatomic, strong) id <CCTransactionWithObject> answerTransaction;
@property (nonatomic, strong) id <CCTransactionWithObject> bookDetailsTransaction;

@end
