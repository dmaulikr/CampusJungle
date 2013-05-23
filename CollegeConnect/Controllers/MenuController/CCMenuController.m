//
//  CCMenuControllerViewController.m
//  CollegeConnect
//
//  Created by Vlad Korzun on 21.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCMenuController.h"

@interface CCMenuController ()

@end

@implementation CCMenuController

-(void)viewDidAppear:(BOOL)animated
{
    if(self.blockOnViewDidAppear){
        self.blockOnViewDidAppear();
        self.blockOnViewDidAppear = nil;
    }
}

@end
