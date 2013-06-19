//
//  CCShowNotesForClassTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 19.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCShowNotesForClassTransaction.h"
#import "CCViewMarketNotesListTransaction.h"
#import "CCClass.h"
#import "CCDefines.h"
#import "CCMarketNotesProvider.h"
#import "CCViewMarketNotesListTransaction.h"

@implementation CCShowNotesForClassTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    
    CCViewMarketNotesListTransaction *viewMarketListTransaction = [CCViewMarketNotesListTransaction new];
    viewMarketListTransaction.navigation = self.navigation;
   
    CCClass *currentClass = object;
    NSDictionary *filter = @{CCMarketFilterConstants.classes : currentClass.classID};
    
    CCMarketNotesProvider *marketNotes = [CCMarketNotesProvider new];
    marketNotes.order = CCMarketFilterConstants.orderTop;
    marketNotes.filters = filter;
    
    [viewMarketListTransaction performWithObject:marketNotes];
}

@end
