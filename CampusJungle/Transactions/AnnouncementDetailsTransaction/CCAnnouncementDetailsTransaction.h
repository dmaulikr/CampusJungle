//
//  CCAnnouncementDetailsTransaction.h
//  CampusJungle
//
//  Created by Vlad Korzun on 07.09.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTransactionWithObject.h"

@interface CCAnnouncementDetailsTransaction : NSObject <CCTransactionWithObject>

@property (nonatomic, weak) UINavigationController *navigation;

@end
