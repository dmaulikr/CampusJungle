//
//  CCMessageDetailsTransaction.h
//  CampusJungle
//
//  Created by Vlad Korzun on 12.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTransactionWithObject.h"

@interface CCMessageDetailsTransaction : NSObject <CCTransactionWithObject>

@property (nonatomic, weak) UINavigationController *navigation;

@end
