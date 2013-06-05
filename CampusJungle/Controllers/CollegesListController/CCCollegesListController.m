//
//  CCCollegesListController.m
//  CampusJungle
//
//  Created by Yulia Petryshena on 6/5/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCCollegesListController.h"

@interface CCCollegesListController ()

@property (nonatomic, strong) NSArray *collegesArray;

@end

@implementation CCCollegesListController

-(id)initWithArray:(NSArray*)educations
{
    self = [super init];
    if (self) {
        self.collegesArray = educations;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setTitle:@"Select College"];
}

@end
