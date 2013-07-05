//
//  GIAlertButton.h
//  GiftIt
//
//  Created by Vlad Korzun on 20.03.13.
//  Copyright (c) 2013 Julia Petryshena. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ObjectRemovingProtocol <NSObject>
- (void)remove;
@end

typedef void(^Action)(void);

@interface GIAlertButton : UIButton
@property (nonatomic,copy) Action actionOnClick;
@property (nonatomic,strong) id<ObjectRemovingProtocol>containingObject;
@property (nonatomic) BOOL isCancel;

+(GIAlertButton*)buttonWithTitle:(NSString*)title action:(Action)actionOnClick;
+(GIAlertButton*)cancelButtonWithTitle:(NSString *)title action:(Action)actionOnClick;
+(GIAlertButton*)actionSheetButtonWithTitle:(NSString *)title action:(Action)actionOnClick;
@end
