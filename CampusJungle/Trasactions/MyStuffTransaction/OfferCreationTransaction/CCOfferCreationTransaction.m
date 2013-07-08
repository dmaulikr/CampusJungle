//
//  CCOfferCreationTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 08.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCOfferCreationTransaction.h"
#import "CCOfferControllerViewController.h"

@implementation CCOfferCreationTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    CCOfferControllerViewController *offerController = [CCOfferControllerViewController new];
    offerController.currentStuff = object;
    [self.navigation pushViewController:offerController animated:YES];
}

@end
