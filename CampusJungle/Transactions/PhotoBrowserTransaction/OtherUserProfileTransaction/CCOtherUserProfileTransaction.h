//
//  CCOtherUserProfileTransaction.h
//  CampusJungle
//
//  Created by Vlad Korzun on 05.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTransactionWithObject.h"

@interface CCOtherUserProfileTransaction : NSObject<CCTransactionWithObject>

@property (nonatomic, weak) UINavigationController *navigation;

@end
