//
//  CCEditClassTransaction.h
//  CampusJungle
//
//  Created by Vlad Korzun on 17.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTransactionWithObject.h"
#import "CCClassController.h"

@interface CCEditClassTransaction : NSObject <CCTransactionWithObject>

@property (nonatomic, strong) UINavigationController *navigation;
@property (nonatomic, weak) CCClassController *classController;

@end
