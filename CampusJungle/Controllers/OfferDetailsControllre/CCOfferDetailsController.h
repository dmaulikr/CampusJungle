//
//  CCOfferDetailsController.h
//  CampusJungle
//
//  Created by Vlad Korzun on 09.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCViewController.h"
#import "CCOffer.h"
#import "CCTransactionWithObject.h"

@interface CCOfferDetailsController : CCViewController

@property (nonatomic, strong) CCOffer *offer;
@property (nonatomic, strong) id <CCTransactionWithObject> senderDetailsTransaction;
@property (nonatomic, strong) id <CCTransactionWithObject> stuffDetailsTransaction;

@end
