//
//  CCNote.h
//  CampusJungle
//
//  Created by Vlad Korzun on 08.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCNote : NSObject

@property (nonatomic, strong) NSNumber *collegeID;
@property (nonatomic, strong) NSString *noteDescription;
@property (nonatomic, strong) NSNumber *classID;
@property (nonatomic, strong) NSString *tagsString;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, strong) UIImage *thumbnail;

@property (nonatomic, strong) NSString *link;

@end
