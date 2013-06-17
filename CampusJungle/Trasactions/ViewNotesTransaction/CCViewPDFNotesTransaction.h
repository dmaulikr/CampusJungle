//
//  CCViewNotesTransaction.h
//  CampusJungle
//
//  Created by Vlad Korzun on 09.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTransactionWithObject.h"

@interface CCViewPDFNotesTransaction : NSObject<CCTransactionWithObject>

@property (nonatomic, strong) UINavigationController *navigation;

@end
