//
//  CCMessage.h
//  CampusJungle
//
//  Created by Vlad Korzun on 10.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCMessage : NSObject

@property (nonatomic, strong) NSString *messageID;
@property (nonatomic, strong) NSString *receiverID;
@property (nonatomic, strong) NSString *receiverType;
@property (nonatomic, strong) NSString *senderID;
@property (nonatomic, strong) NSString *text;

+ (NSDictionary *)responseMappingDictionary;

@end

