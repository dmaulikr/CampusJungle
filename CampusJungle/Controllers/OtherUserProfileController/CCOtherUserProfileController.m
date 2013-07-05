//
//  CCOtherUserProfileController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 05.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCOtherUserProfileController.h"

@interface CCOtherUserProfileController ()

@property (nonatomic, strong) IBOutlet UIImageView *avatar;
@property (nonatomic, strong) IBOutlet UILabel *firstNameLabel;
@property (nonatomic, strong) IBOutlet UILabel *lastNameLabel;

@end

@implementation CCOtherUserProfileController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *avatarPath = [NSString stringWithFormat:@"%@%@",CCAPIDefines.baseURL,self.currentUser.avatar];
    [self.avatar setImageWithURL:[NSURL URLWithString:avatarPath] placeholderImage:[UIImage imageNamed:@"avatar_placeholder"]];
    self.lastNameLabel.text = self.currentUser.lastName;
    self.firstNameLabel.text = self.currentUser.firstName;
    self.title = @"Profile";
}

@end
