//
//  CCOfferCreationTransaction.h
//  CampusJungle
//
//  Created by Vlad Korzun on 08.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTransactionWithObject.h"

@interface CCOfferCreationTransaction : NSObject<CCTransactionWithObject>

@property (nonatomic, strong) UINavigationController *navigation;

@end
