//
//  CCLocationDataProviderDelegate.h
//  CampusJungle
//
//  Created by Yury Grinenko on 08.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CCLocationDataProviderDelegate <NSObject>

- (void)didLoadLocations:(NSArray *)locationsArray;

@end
