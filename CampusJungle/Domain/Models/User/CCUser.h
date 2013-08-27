//
//  CCUser.h
//  CollegeConnect
//
//  Created by Vlad Korzun on 21.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//
#import "CCRestKitMappableModel.h"
#import "CCModelIdAccessorProtocol.h"

@interface CCUser : NSObject <CCRestKitMappableModel, CCModelTypeProtocol>

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *rank;
@property (nonatomic, strong) NSString *wallet;
@property (nonatomic, strong) NSString *bonusWallet;
@property (nonatomic, strong) NSArray *authentications;
@property (nonatomic, strong) NSNumber *isFacebookLinked;
@property (nonatomic, strong) NSArray *educations;
@property (nonatomic, assign) BOOL isSelected;

- (double)totalWallet;
+ (NSDictionary *) responseMappingDictionary;
@end