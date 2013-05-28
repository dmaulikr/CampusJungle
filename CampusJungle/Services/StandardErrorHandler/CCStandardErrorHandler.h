//
//  CCStandardErrorHandler.h
//  CampusJungle
//
//  Created by Vlad Korzun on 27.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCStandardErrorHandler : NSObject

+ (void)showErrorWithTitle:(NSString *)title message:(NSString *)message;
+ (void)showErrorWithCode:(NSInteger)code;
+ (void)showErrorWithError:(NSError *)error;

@end
