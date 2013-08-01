//
//  CCInviterSelectionController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 31.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCInviterSelectionController.h"
#import "CCUserDataProvider.h"
#import "CCUserCell.h"
#import "CCAPIProviderProtocol.h"
#import "CCStandardErrorHandler.h"

@interface CCInviterSelectionController ()

@property (nonatomic, strong) CCUserDataProvider *dataProvider;
@property (nonatomic, strong) id <CCAPIProviderProtocol> ioc_apiProvider;

@end

@implementation CCInviterSelectionController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Inviter";
    self.dataProvider = [CCUserDataProvider new];
    [self setRightNavigationItemWithTitle:@"Skip" selector:@selector(skip)];
    [self configTableWithProvider:self.dataProvider cellClass:[CCUserCell class]];
}

- (void)skip
{
    [self.tutorialTransaction perform];
}

- (void)didSelectedCellWithObject:(CCUser *)cellObject
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.ioc_apiProvider postInviter:cellObject.uid successHandler:^(RKMappingResult *result) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self.tutorialTransaction perform];
    } errorHandler:^(NSError *error) {
        [CCStandardErrorHandler showErrorWithError:error];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
    
}

@end
