//
//  CCUser.h
//  CollegeConnect
//
//  Created by Vlad Korzun on 21.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

@interface CCUser : NSObject

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *rank;
@property (nonatomic, strong) NSString *wallet;
@property (nonatomic, strong) NSArray *authentications;
@property (nonatomic, strong) NSString *isFacebookLinked;
@property (nonatomic, strong) NSArray *educations;

@end