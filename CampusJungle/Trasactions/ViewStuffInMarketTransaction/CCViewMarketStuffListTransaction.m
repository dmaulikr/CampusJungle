//
//  CCViewMarketStuffListTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 21.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCViewMarketStuffListTransaction.h"
#import "CCListOfStuffInMarketController.h"

@implementation CCViewMarketStuffListTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    NSParameterAssert(object);

    CCListOfStuffInMarketController *listOfNotesController = [CCListOfStuffInMarketController new];
    listOfNotesController.tableProvider = object;
    [self.navigation pushViewController:listOfNotesController animated:YES];
}

@end
