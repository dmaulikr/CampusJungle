//
//  CCStuffDetailsController.h
//  CampusJungle
//
//  Created by Vlad Korzun on 21.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCViewController.h"
#import "CCStuff.h"
#import "CCTransactionWithObject.h"

@interface CCStuffDetailsController : CCViewController

@property (nonatomic, strong) CCStuff *stuff;

@property (nonatomic, strong) id <CCTransactionWithObject> photoBrowserTransaction;

@end
