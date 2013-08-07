//
//  CCBackTransactionAfterClassUpdate.h
//  CampusJungle
//
//  Created by Vlad Korzun on 17.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCClassController.h"
#import "CCTransactionWithObject.h"

@protocol CCClassUpdateProtocol <NSObject>

- (void)updateWithClass:(CCClass *)classObject;

@end

@interface CCBackTransactionAfterClassUpdate : NSObject<CCTransactionWithObject>

@property (nonatomic, weak) UINavigationController *navigation;
@property (nonatomic, weak) id<CCClassUpdateProtocol> previousController;

@end
