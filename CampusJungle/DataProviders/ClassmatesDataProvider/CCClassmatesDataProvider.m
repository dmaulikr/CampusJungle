//
//  CCClassmatesDataProvider.m
//  CampusJungle
//
//  Created by Vlad Korzun on 05.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCClassmatesDataProvider.h"

@implementation CCClassmatesDataProvider

- (void)loadItemsForPageNumber:(long)numberOfPage successHandler:(successWithObject)successHandler
{
    [self.ioc_apiProvider loadClassmatesForClass:self.classID
                                    NumberOfPage:[NSNumber numberWithLong:numberOfPage]
                                  successHandler:^(RKMappingResult *result) {
                                      successHandler(result.firstObject);
                                  } errorHandler:^(NSError *error) {
                                      [self showErrorWhileLoading:error];
                                  }];
}

@end
