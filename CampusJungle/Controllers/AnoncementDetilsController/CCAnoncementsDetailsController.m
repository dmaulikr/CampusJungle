//
//  CCAnoncementsDetailsController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 07.09.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAnoncementsDetailsController.h"

@interface CCAnoncementsDetailsController ()

@property (nonatomic, strong) IBOutlet UILabel *topicLabel;
@property (nonatomic, strong) IBOutlet UITextView *textView;

@end

@implementation CCAnoncementsDetailsController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Announcement";
    self.topicLabel.text = self.announcement.topic;
    self.textView.text = self.announcement.message;
}

@end
