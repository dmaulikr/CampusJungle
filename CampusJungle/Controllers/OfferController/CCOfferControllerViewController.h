//
//  CCOfferControllerViewController.h
//  CampusJungle
//
//  Created by Vlad Korzun on 08.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCBaseViewController.h"
#import "CCStuff.h" 
#import "CCTransaction.h"

@interface CCOfferControllerViewController : CCBaseViewController

@property (nonatomic, strong) CCStuff *currentStuff;
@property (nonatomic, strong) id <CCTransaction> backToStuffTransaction;

@end
