//
//  CCImagesForNotesUploadingScreenTransaction.h
//  CampusJungle
//
//  Created by Vlad Korzun on 10.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTransactionWithObject.h"

@interface CCImagesForNotesUploadingScreenTransaction : NSObject <CCTransactionWithObject>

@property (nonatomic, strong) UINavigationController *naviation;

@end