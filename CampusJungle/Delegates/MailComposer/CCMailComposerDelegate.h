//
//  CCMailComposerDelegate.h
//  CampusJungle
//
//  Created by Yury Grinenko on 09.01.13.
//  Copyright (c) 2013 111Minutes. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^MailComposerSuccessBlock)(void);
typedef void(^MailComposerErrorBlock)(void);
typedef void(^MailComposerCancelBlock)(void);

@interface CCMailComposerDelegate : NSObject <MFMailComposeViewControllerDelegate>

- (id)initWithSuccessBlock:(MailComposerSuccessBlock)successBlock errorBlock:(MailComposerErrorBlock)errorBlock cancelBlock:(MailComposerCancelBlock)cancelBlock;

@end
