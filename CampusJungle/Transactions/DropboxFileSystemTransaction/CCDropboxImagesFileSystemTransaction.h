//
//  CCDropboxFileSystemTransaction.h
//  CampusJungle
//
//  Created by Vlad Korzun on 05.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTransactionWithObject.h"
#import "CCTransaction.h" 
#import "CCTypesDefinition.h"

@interface CCDropboxImagesFileSystemTransaction : NSObject<CCTransactionWithObject>

@property (nonatomic, weak) UINavigationController *navigation;
@property (nonatomic, strong) id <CCTransaction> backToListTransaction;
@property (nonatomic, strong) id <CCTransactionWithObject> imagesSortingTransaction;
@property (nonatomic, copy) DropboxUploadingBlock uploadingBlock;

@end
