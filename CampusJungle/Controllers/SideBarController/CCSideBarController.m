//
//  CCSideBarController.m
//  CampusJungle
//
//  Created by Yulia Petryshena on 5/28/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCSideBarController.h"

@implementation CCSideBarController

- (id)init {
    if (self = [super init]) {
        [self addObserver:self forKeyPath:@"state" options:NSKeyValueObservingOptionInitial context:nil];
    }
    return self;
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {

    if ([keyPath isEqualToString:@"state"]) {
       [self.view endEditing:YES];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context]; 
    }
}

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
