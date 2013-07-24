//
//  CCOtherUserProfileController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 05.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCOtherUserProfileController.h"
#import "DYRateView.h"

@interface CCOtherUserProfileController ()

@property (nonatomic, strong) IBOutlet UIImageView *avatar;
@property (nonatomic, strong) IBOutlet UILabel *firstNameLabel;
@property (nonatomic, strong) IBOutlet UILabel *lastNameLabel;
@property (nonatomic, weak) IBOutlet UIView *rateContainer;
@property (nonatomic, strong) DYRateView *rateView;

- (IBAction)sendMessage;

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
    [self configStars];
    self.rateView.rate = self.currentUser.rank.floatValue;
}

- (void)configStars
{
    self.rateView = [[DYRateView alloc] initWithFrame:self.rateContainer.bounds fullStar:[self scaledImageWithName:@"star_icon_active"] emptyStar:[self scaledImageWithName:@"star_icon"]];
    [self.rateContainer addSubview:self.rateView];
    self.rateView.alignment = RateViewAlignmentCenter;
}

- (UIImage *)scaledImageWithName:(NSString *)name
{
    UIImage *originalImage = [UIImage imageNamed:name];
    UIImage *scaledImage =
    [UIImage imageWithCGImage:[originalImage CGImage]
                        scale:(originalImage.scale * 2.0)
                  orientation:(originalImage.imageOrientation)];
    return scaledImage;
}

- (IBAction)sendMessage
{
    [self.sendMessageTransaction performWithObject:self.currentUser];
}

@end
