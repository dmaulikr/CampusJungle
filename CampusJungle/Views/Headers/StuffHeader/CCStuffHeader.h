//
//  CCStuffHeader.h
//  CampusJungle
//
//  Created by Yury Grinenko on 25.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CCStuff;

@protocol CCStuffHeaderDelegate <NSObject>

- (void)makeOfferButtonDidPressed:(id)sender;
- (void)deleteStuffButtonDidPressed:(id)sender;

@end

@interface CCStuffHeader : UICollectionReusableView

- (void)setStuff:(CCStuff *)stuff;
- (void)setDelegate:(id<CCStuffHeaderDelegate>)delegate;

@end
