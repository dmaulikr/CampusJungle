//
//  CCClass.h
//  CampusJungle
//
//  Created by Yulia Petryshena on 6/3/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCClass : NSObject

@property (nonatomic, strong) NSString *professor;
@property (nonatomic, strong) NSString *collegeID;
@property (nonatomic, strong) NSString *semester;
@property (nonatomic, strong) NSString *subject;
@property (nonatomic, strong) NSArray *timetable;
@property (nonatomic, strong) NSDictionary *timeClassesAreTaken;
@property (nonatomic, strong) NSString *callNumber;

@end
