//
//  CCBookOfferTransaction.h
//  CampusJungle
//
//  Created by Vlad Korzun on 07.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTransactionWithObject.h"

@interface CCBookOfferTransaction : NSObject<CCTransactionWithObject>

@property (nonatomic, strong) UINavigationController *navigation;

@end
