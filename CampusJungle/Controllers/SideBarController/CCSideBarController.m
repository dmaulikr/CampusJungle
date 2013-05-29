//
//  CCSideBarController.m
//  CampusJungle
//
//  Created by Yulia Petryshena on 5/28/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCSideBarController.h"

@implementation CCSideBarController

-(void)viewDidAppear:(BOOL)animated
{
    if(self.blockOnViewDidAppear){
        self.blockOnViewDidAppear();
        self.blockOnViewDidAppear = nil;
    }
}

- (UIBarButtonItem *)leftButtonForCenterPanel {
    return [[UIBarButtonItem alloc] initWithImage:[[self class] defaultImage] style:UIBarButtonItemStylePlain target:self action:@selector(toggleLeftPanel:)];
}

@end
