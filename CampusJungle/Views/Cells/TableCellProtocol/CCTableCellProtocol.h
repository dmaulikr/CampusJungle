//
//  CCTableCellProtocol.h
//  CampusJungle
//
//  Created by Vlad Korzun on 29.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CCTableCellProtocol <NSObject>

@property (nonatomic, strong) id cellObject;

@optional
@property (nonatomic) BOOL isEven;

@end
