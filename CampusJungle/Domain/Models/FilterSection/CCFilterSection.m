//
//  CCFilterSection.m
//  CampusJungle
//
//  Created by Vlad Korzun on 13.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCFilterSection.h"

@implementation CCFilterSection

- (id)init
{
    if(self = [super init]){
        self.classes = [NSMutableArray new];
    }
    return self;
}

@end
