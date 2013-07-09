//
//  CCOfferControllerViewController.h
//  CampusJungle
//
//  Created by Vlad Korzun on 08.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCViewController.h"
#import "CCStuff.h" 
#import "CCTransaction.h"

@interface CCOfferControllerViewController : CCViewController

@property (nonatomic, strong) CCStuff *currentStuff;
@property (nonatomic, strong) id <CCTransaction> backToStuffTransaction;

@end
