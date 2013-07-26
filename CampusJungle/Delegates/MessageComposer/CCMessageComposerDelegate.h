//
//  CCMessageComposerDelegate.h
//  CampusJungle
//
//  Created by Yury Grinenko on 09.01.13.
//  Copyright (c) 2013 111Minutes. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^MessageComposerSuccessBlock)(void);
typedef void(^MessageComposerErrorBlock)(void);
typedef void(^MessageComposerCancelBlock)(void);

@interface CCMessageComposerDelegate : NSObject <MFMessageComposeViewControllerDelegate>

- (id)initWithSuccessBlock:(MessageComposerSuccessBlock)successBlock errorBlock:(MessageComposerErrorBlock)errorBlock cancelBlock:(MessageComposerCancelBlock)cancelBlock;

@end
