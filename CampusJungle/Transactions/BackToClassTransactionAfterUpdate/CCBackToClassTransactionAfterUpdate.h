//
//  CCBackToClassTransactionAfterUpdate.h
//  CampusJungle
//
//  Created by Vlad Korzun on 17.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCClassController.h"
#import "CCTransactionWithObject.h"

@interface CCBackToClassTransactionAfterUpdate : NSObject<CCTransactionWithObject>

@property (nonatomic, strong) UINavigationController *navigation;
@property (nonatomic, weak) CCClassController *classControler;

@end
