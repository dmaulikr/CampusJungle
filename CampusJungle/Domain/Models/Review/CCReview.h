//
//  CCReview.h
//  CampusJungle
//
//  Created by Vlad Korzun on 11.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCRestKitMappableModel.h"
#import "CCModelIdAccessorProtocol.h"

@interface CCReview : NSObject <CCRestKitMappableModel, CCModelTypeProtocol>

@property (nonatomic, strong) NSString *reviewID;
@property (nonatomic ,strong) NSString *text;
@property (nonatomic, strong) NSString *reviewerID;
@property (nonatomic, strong) NSString *reviewedID;
@property (nonatomic, strong) NSNumber *rank;
@property (nonatomic, strong) NSDate *createdDate;

@end