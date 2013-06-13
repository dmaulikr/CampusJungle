//
//  CCFilterSection.h
//  CampusJungle
//
//  Created by Vlad Korzun on 13.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCFilterSection : NSObject

@property (nonatomic) BOOL isOpen;
@property (nonatomic, strong) NSString *collegeName;
@property (nonatomic) NSInteger index;
@property (nonatomic) NSInteger collegeID;
@property (nonatomic, strong) NSMutableArray *classes;

@end
