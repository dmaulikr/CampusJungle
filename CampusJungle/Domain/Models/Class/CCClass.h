//
//  CCClass.h
//  CampusJungle
//
//  Created by Yulia Petryshena on 6/3/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCRestKitMappableModel.h"
#import "CCModelIdAccessorProtocol.h"

@interface CCClass : NSObject <CCRestKitMappableModel, CCModelTypeProtocol>

@property (nonatomic, strong) NSString *professor;
@property (nonatomic, strong) NSString *collegeID;
@property (nonatomic, strong) NSString *semester;
@property (nonatomic, strong) NSString *subject;
@property (nonatomic, strong) NSArray *timetable;
@property (nonatomic, strong) NSDictionary *timeClassesAreTaken;
@property (nonatomic, strong) NSString *callNumber;
@property (nonatomic, strong) NSString *classID;
@property (nonatomic, strong) NSString *collegeName;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) UIImage *thumb;
@property (nonatomic, strong) NSString *classImageURL;
@property (nonatomic, strong) NSNumber *isProfessor;

@property (nonatomic) BOOL isSelected;

- (NSString *)name;

@end
