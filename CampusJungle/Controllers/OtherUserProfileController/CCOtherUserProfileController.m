//
//  CCOtherUserProfileController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 05.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCOtherUserProfileController.h"
#import "DYRateView.h"
#import "CCUIImageHelper.h"
#import "CCCommonClassesDataProvider.h"
#import "CCOrdinaryCell.h"

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
    CCCommonClassesDataProvider *dataProvider = [CCCommonClassesDataProvider new];
    dataProvider.userID = self.currentUser.uid;
    [self configTableWithProvider:dataProvider cellClass:[CCOrdinaryCell class]];
}

- (void)configStars
{
    self.rateView = [[DYRateView alloc] initWithFrame:self.rateContainer.bounds fullStar:[CCUIImageHelper scaleImageWithName:@"star_icon_active" withScale:2.0] emptyStar:[CCUIImageHelper scaleImageWithName:@"star_icon" withScale:2.0]];
    [self.rateContainer addSubview:self.rateView];
    self.rateView.alignment = RateViewAlignmentCenter;
}

- (IBAction)sendMessage
{
    [self.sendMessageTransaction performWithObject:self.currentUser];
}

- (BOOL)isNeedToLeftSelected
{
    return NO;
}

- (void)didSelectedCellWithObject:(id)cellObject
{
    [self.classTransaction performWithObject:cellObject];
}

@end
