//
//  CCDropboxFileSystemTransaction.h
//  CampusJungle
//
//  Created by Vlad Korzun on 05.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTransactionWithObject.h"

@interface CCDropboxFileSystemTransaction : NSObject<CCTransactionWithObject>

@property (nonatomic, strong) UINavigationController *navigation;

@end
