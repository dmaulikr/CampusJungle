//
//  CCComment.h
//  CampusJungle
//
//  Created by Yury Grinenko on 17.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCRestKitMappableModel.h"

@interface CCComment : NSObject <CCRestKitMappableModel>

@property (nonatomic, strong) NSString *commentId;
@property (nonatomic, strong) NSString *answerId;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *ownerId;
@property (nonatomic, strong) NSString *ownerFirstName;
@property (nonatomic, strong) NSString *ownerLastName;

@end
