//
//  CCStuffDetailsController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 21.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCStuffDetailsController.h"
#import "CCDefines.h"
#import "CCBaseDataProvider.h"
#import "CCStuffCollectionViewDataSource.h"
#import "CCPhotosDataProvider.h"
#import "CCPhotoCell.h"
#import "CCStuffHeader.h"
#import "CCUserSessionProtocol.h"
#import "CCStuffAPIProviderProtocol.h"
#import "CCAlertHelper.h"

@interface CCStuffDetailsController ()<CCCellSelectionProtocol, CCStuffHeaderDelegate>

@property (nonatomic, weak) IBOutlet UICollectionView *stuffPhotos;

@property (nonatomic, strong) CCStuffCollectionViewDataSource *dataSource;
@property (nonatomic, strong) CCPhotosDataProvider *dataProvider;
@property (nonatomic, strong) id<CCUserSessionProtocol> ioc_userSession;
@property (nonatomic, strong) id<CCStuffAPIProviderProtocol> ioc_stuffApiProvider;

@end

@implementation CCStuffDetailsController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupCollectionView];
    
    [self.tapRecognizer setEnabled:NO];
    [self setTitle:@"Stuff Details"];
}

- (void)setupCollectionView
{
    self.dataProvider = [CCPhotosDataProvider new];
    self.dataProvider.photos = self.stuff.photos;
    [self configCollection:self.stuffPhotos WithProvider:self.dataProvider cellClass:[CCPhotoCell class]];
}

- (void)configCollection:(UICollectionView *)collectionView WithProvider:(CCBaseDataProvider *)provider cellClass:(Class)cellCass
{
    self.dataSource = [CCStuffCollectionViewDataSource new];
    [self.dataSource setStuff:self.stuff];
    [self.dataSource setStuffHeaderDelegate:self];
    
    [collectionView registerClass:cellCass forCellWithReuseIdentifier:CCTableDefines.collectionCellIdentifier];
    
    self.dataSource.dataProvider = provider;
    self.dataSource.dataProvider.targetTable = (UITableView *)collectionView;
    collectionView.dataSource = self.dataSource;
    collectionView.delegate = self.dataSource;
        
    self.dataSource.delegate = self;
    [provider loadItems];
}

#pragma mark -
#pragma mark Actions
- (void)didSelectedCellWithObject:(id)cellObject
{
    [self.photoBrowserTransaction performWithObject:@{
            @"photosProvider" : self.dataProvider,
            @"selectedPhoto" : cellObject,
     }];
}

#pragma mark -
#pragma mark CCStuffHeaderDelegate
- (void)makeOfferButtonDidPressed:(id)sender
{
    [self.createOfferTarnasaction performWithObject:self.stuff];
}

- (void)deleteStuffButtonDidPressed:(id)sender
{
    __weak CCStuffDetailsController *weakSelf = self;
    [CCAlertHelper showWithMessage:CCAlertsMessages.deleteStuff success:^{
        [weakSelf.ioc_stuffApiProvider deleteStuffWithId:weakSelf.stuff.stuffID successHandler:^(RKMappingResult *result) {
            [SVProgressHUD showSuccessWithStatus:CCSuccessMessages.deleteStuff duration:CCProgressHudsConstants.loaderDuration];
            [weakSelf.backTransaction perform];
        } errorHandler:^(NSError *error) {
            [CCStandardErrorHandler showErrorWithError:error];
        }];
    }];
}

@end
