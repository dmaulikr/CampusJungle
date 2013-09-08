//
//  CCAnnouncementsControllerViewController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 22.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAnnouncementsController.h"
#import "CCNavigationBarViewHelper.h"
#import "CCAnnouncementDataProvider.h"
#import "CCOrdinaryCell.h"
#import "CCAnnouncementCell.h"
#import "CCAnnouncementAPIProviderProtocol.h"
#import "CCStandardErrorHandler.h"

@interface CCAnnouncementsController ()<CCAnnouncementCellDelegate>

@property (nonatomic, strong) CCAnnouncementDataProvider *dataProvider;
@property (nonatomic, strong) id <CCAnnouncementAPIProviderProtocol> ioc_announcementAPIProvider;

@end

@implementation CCAnnouncementsController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [CCNavigationBarViewHelper plusButtonWithTarget:self action:@selector(addAnnouncement)];
    self.title = @"Announcements";
    
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle: @"Back" style: UIBarButtonItemStyleBordered target: nil action: nil];
    [[self navigationItem] setBackBarButtonItem: newBackButton];
    
    [self setupTableView];
}

- (void)addAnnouncement
{
    [self.addAnnouncementTransaction performWithObject:self.currentClass];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.dataProvider loadItems];
}

- (void)setupTableView
{
    self.dataProvider = [CCAnnouncementDataProvider new];
    self.dataProvider.delegate = self;
    [self.dataProvider setClassID:self.currentClass.classID];
    [self configTableWithProvider:self.dataProvider cellClass:[CCAnnouncementCell class]];
}

-(BOOL)isNeedToLeftSelected
{
    return NO;
}

- (void)deleteAnnouncement:(CCAnnouncement *)announcement
{
    [self.ioc_announcementAPIProvider deleteAnnouncement:announcement successHandler:^(RKMappingResult *result) {
        [self.dataProvider deleteItem:announcement];
        [SVProgressHUD showSuccessWithStatus:CCSuccessMessages.removeAnnouncement duration:CCProgressHudsConstants.loaderDuration];
    } errorHandler:^(NSError *error) {
        [CCStandardErrorHandler showErrorWithError:error];
    }];
}

- (void)didSelectedCellWithObject:(id)cellObject
{
    [self.announcementDetailsTransaction performWithObject:cellObject];
}

@end
