//
//  CCUIImageHelper.h
//  CampusJungle
//
//  Created by Vlad Korzun on 10.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCUIImageHelper : NSObject

+ (UIImage *)fixOrientationOfImage:(UIImage *)image;
+ (UIImage *)scaleImage:(UIImage *)image withScale:(CGFloat)scale;
+ (UIImage *)scaleImageWithName:(NSString *)name withScale:(CGFloat)scale;
@end
