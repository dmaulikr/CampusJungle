//
//  CCStuffDetailsTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 21.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCStuffDetailsTransaction.h"
#import "CCStuffDetailsController.h"

@implementation CCStuffDetailsTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    
    CCStuffDetailsController *stuffDetailsController = [CCStuffDetailsController new];
    stuffDetailsController.stuff = object;
    
    [self.navigation pushViewController:stuffDetailsController animated:YES];
    
}

@end
