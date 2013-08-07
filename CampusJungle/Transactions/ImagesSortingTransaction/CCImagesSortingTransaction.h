//
//  CCImagesSortingTransaction.h
//  CampusJungle
//
//  Created by Vlad Korzun on 10.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTransactionWithObject.h"
#import "CCTransaction.h"
#import "CCTypesDefinition.h"

@interface CCImagesSortingTransaction : NSObject<CCTransactionWithObject>

@property (nonatomic, strong) id <CCTransaction> backToListTransaction;
@property (nonatomic, weak) UINavigationController *navigation;
@property (nonatomic, strong) Class sortingControllerClass;
@property (nonatomic, copy) DropboxUploadingBlock uploadingBlock;

@end
