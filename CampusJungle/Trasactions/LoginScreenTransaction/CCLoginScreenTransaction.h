//
//  CCLoginScreenTransaction.h
//  CollegeConnect
//
//  Created by Vlad Korzun on 22.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCTransaction.h"

@interface CCLoginScreenTransaction : NSObject <CCTransaction>

@property (nonatomic, strong) id <CCTransaction> loginTransaction;
@property (nonatomic, strong) UINavigationController *navigation;

@end
