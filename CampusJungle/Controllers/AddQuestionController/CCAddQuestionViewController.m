//
//  CCAddQuestionViewController.m
//  CampusJungle
//
//  Created by Yury Grinenko on 15.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAddQuestionViewController.h"
#import "CCForum.h"

@interface CCAddQuestionViewController ()

@property (nonatomic, strong) CCForum *forum;

@end

@implementation CCAddQuestionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitle:@"Add Question"];
}

@end
