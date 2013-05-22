//
//  CCUser.h
//  CollegeConnect
//
//  Created by Vlad Korzun on 21.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCUser : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSNumber *UID; //id
@property (nonatomic, strong) NSNumber *rank;
@property (nonatomic, strong) NSNumber *wallet;
@property (nonatomic, strong) NSArray *authentications;

+ (CCUser *)userFromFacebookDictionary:(NSDictionary *)dictionary;

@end