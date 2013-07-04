//
//  CCActionSheetPickerCollegesDelegate.h
//  CampusJungle
//
//  Created by Vlad Korzun on 19.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCCellSelectionProtocol.h"
#import "ActionSheetCustomPickerDelegate.h"

@interface CCActionSheetPickerCollegesDelegate : NSObject <ActionSheetCustomPickerDelegate>

@property (nonatomic, strong) NSArray *arrayOfItems;
@property (nonatomic, strong) id<CCCellSelectionProtocol> delegate;

@end
