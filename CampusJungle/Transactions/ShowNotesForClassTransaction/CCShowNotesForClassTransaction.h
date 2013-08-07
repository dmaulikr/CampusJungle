//
//  CCShowNotesForClassTransaction.h
//  CampusJungle
//
//  Created by Vlad Korzun on 19.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTransactionWithObject.h"

@interface CCShowNotesForClassTransaction : NSObject<CCTransactionWithObject>

@property (nonatomic, weak) UINavigationController *navigation;

@end
