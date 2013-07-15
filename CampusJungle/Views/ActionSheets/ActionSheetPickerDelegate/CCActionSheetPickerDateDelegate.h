//
//  CCActionSheetPickerDelegate.h
//  CampusJungle
//
//  Created by Yulia Petryshena on 6/13/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActionSheetPicker.h"

@protocol DatePickerDelegateProtocol <NSObject>

- (void)lesson:(NSDictionary *)lesson didUpdateWithObject:(NSDictionary *)newLesson;
- (void)lessonDidCreate:(NSDictionary *)object;

@end

@interface CCActionSheetPickerDateDelegate : NSObject <ActionSheetCustomPickerDelegate>

- (id)initWithDate:(NSDictionary *)date;

@property (nonatomic, weak) id <DatePickerDelegateProtocol> delegate;
@property (nonatomic, strong) NSDictionary *beginTime;

@end