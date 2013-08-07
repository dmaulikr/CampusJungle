//
//  CCSearchCollegeTransaction.h
//  CampusJungle
//
//  Created by Vlad Korzun on 25.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTransaction.h"

@interface CCSearchCollegeTransaction : NSObject <CCTransaction>

@property (nonatomic, weak) UINavigationController *navigation;
@property (nonatomic, strong) NSMutableArray *arrayOfColleges;

@end
