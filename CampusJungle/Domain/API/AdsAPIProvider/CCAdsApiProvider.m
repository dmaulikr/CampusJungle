//
//  CCAdsApiProvider.m
//  CampusJungle
//
//  Created by Yury Grinenko on 02.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAdsApiProvider.h"

@implementation CCAdsApiProvider

- (void)loadAdsInClassWithId:(NSString *)classId pageNumber:(NSInteger)pageNumber successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler
{
    NSString *path = [NSString stringWithFormat:CCAPIDefines.loadAds, classId];
    NSMutableDictionary *params = [@{@"page_number" : @(pageNumber)} mutableCopy];
    [self loadItemsWithParams:params path:path successHandler:successHandler errorHandler:errorHandler];
}

@end
