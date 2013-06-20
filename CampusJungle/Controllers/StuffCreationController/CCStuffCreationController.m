//
//  CCStuffCreationController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 20.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCStuffCreationController.h"
#import "CCAvatarSelectionProtocol.h"
#import "CCAvatarSelectionActionSheet.h"

@interface CCStuffCreationController () <CCAvatarSelectionProtocol>

@property (nonatomic, strong) IBOutlet UIImageView *thumbImage;
@property (nonatomic, strong) IBOutlet UITextField *decriptionField;
@property (nonatomic, strong) IBOutlet UITextField *priceField;

@property (nonatomic, strong) CCAvatarSelectionActionSheet *thumbSelection;


@end

@implementation CCStuffCreationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.thumbSelection = [CCAvatarSelectionActionSheet new];
    self.thumbSelection.delegate = self;
    self.thumbSelection.title = @"Select thumbnail";
}

- (IBAction)thumbDidPressed
{
    [self.thumbSelection selectAvatar];
}

- (void)didSelectAvatar:(UIImage *)avatar
{
    self.thumbImage.image = avatar;
}

- (IBAction)collegeSelectionButtonDidPressed
{

}

@end
