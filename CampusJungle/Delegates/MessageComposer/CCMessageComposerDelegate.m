//
//  CCMessageComposerDelegate.m
//  CampusJungle
//
//  Created by Yury Grinenko on 09.01.13.
//  Copyright (c) 2013 111Minutes. All rights reserved.
//

#import "CCMessageComposerDelegate.h"

@interface CCMessageComposerDelegate ()<MFMessageComposeViewControllerDelegate>

@property (nonatomic, copy) MessageComposerSuccessBlock successBlock;
@property (nonatomic, copy) MessageComposerErrorBlock errorBlock;
@property (nonatomic, copy) MessageComposerCancelBlock cancelBlock;

@end

@implementation CCMessageComposerDelegate

- (id)initWithSuccessBlock:(MessageComposerSuccessBlock)successBlock errorBlock:(MessageComposerErrorBlock)errorBlock cancelBlock:(MessageComposerCancelBlock)cancelBlock {
    self = [super init];
    if (self) {
        self.successBlock = successBlock;
        self.cancelBlock = cancelBlock;
        self.errorBlock = errorBlock;
    }
    return self;
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    switch(result) {
        case MessageComposeResultSent:
            if (self.successBlock) {
                self.successBlock();
            }
            break;
        case MessageComposeResultFailed:
            if (self.errorBlock) {
                self.errorBlock();
            }
            break;
        case MessageComposeResultCancelled:
            if (self.cancelBlock) {
                self.cancelBlock();
            }
            break;
        default:
            break;
    }
}

@end
