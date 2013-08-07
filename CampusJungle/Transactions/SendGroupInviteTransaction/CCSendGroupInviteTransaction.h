//
//  CCSendGroupInviteTransaction.h
//  CampusJungle
//
//  Created by Yury Grinenko on 24.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTransactionWithObject.h"

@interface CCSendGroupInviteTransaction : NSObject <CCTransactionWithObject>

@property (nonatomic, weak) UINavigationController *navigation;

@end
