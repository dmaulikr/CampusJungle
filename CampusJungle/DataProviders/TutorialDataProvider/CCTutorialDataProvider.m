//
//  CCTutorialDataProvider.m
//  CampusJungle
//
//  Created by Vlad Korzun on 01.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCTutorialDataProvider.h"

@implementation CCTutorialDataProvider

- (void)loadItems
{
    self.arrayOfItems = [self arrayOfImagesFromNames:@[@"background",@"background",@"background"]];
}

- (NSArray *)arrayOfImagesFromNames:(NSArray *)names
{
    NSMutableArray *images = [NSMutableArray new];
    for(NSString *name in names){
        [images addObject:[UIImage imageNamed:name]];
    }
    return images;
}

@end
