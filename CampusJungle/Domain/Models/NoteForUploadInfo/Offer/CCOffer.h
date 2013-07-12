//
//  CCOffer.h
//  CampusJungle
//
//  Created by Vlad Korzun on 08.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCOffer : NSObject

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *receiverID;
@property (nonatomic, strong) NSString *senderID;
@property (nonatomic, strong) NSString *stuffID;
@property (nonatomic, strong) NSString *offerID;
@property (nonatomic, strong) NSString *userFirstName;
@property (nonatomic, strong) NSString *userLastName;
@property (nonatomic, strong) NSString *userAvatar;

+ (NSDictionary *)responseMappingDictionary;

@end
