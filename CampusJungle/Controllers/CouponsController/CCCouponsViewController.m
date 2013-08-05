//
//  CCCouponsViewController.m
//  CampusJungle
//
//  Created by Yury Grinenko on 01.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCCouponsViewController.h"
#import "CCClass.h"
#import "CCAdsDataProvider.h"
#import "CCAdCell.h"
#import "CCViewPositioningHelper.h"
#import "CCAdsDataSource.h"
#import "CCSideMenuHelper.h"

@interface CCCouponsViewController () <CCCellSelectionProtocol, UIGestureRecognizerDelegate>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) CCClass *classObject;
@property (nonatomic, strong) CCAdsDataProvider *dataProvider;
@property (nonatomic, strong) CCAdsDataSource *dataSource;
@property (nonatomic) BOOL isInAction;

@end

@implementation CCCouponsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self configCollectionView];
    [self setTitle:@"Coupons"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [CCSideMenuHelper setSideMenuGestureEnabled:NO];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [CCSideMenuHelper setSideMenuGestureEnabled:YES];
}

- (void)configCollectionView
{
    self.dataProvider = [CCAdsDataProvider new];
    [self.dataProvider setClassId:self.classObject.classID];
    
    self.dataSource = [CCAdsDataSource new];
    [self.collectionView registerClass:[CCAdCell class] forCellWithReuseIdentifier:CCTableDefines.collectionCellIdentifier];
    
    self.dataSource.dataProvider = self.dataProvider;
    self.dataSource.dataProvider.targetTable = (UITableView *)self.collectionView;
    self.collectionView.dataSource = self.dataSource;
    self.collectionView.delegate = self.dataSource;
    
    self.dataSource.delegate = self;
    [self.dataProvider loadItems];
}

#pragma mark -
#pragma mark Actions
- (void)didSelectedCellWithObject:(id)cellObject
{
    
}

- (IBAction)didSwipeRight
{
    if (!self.isInAction && self.collectionView.contentOffset.x > 0) {
        [self.collectionView setContentOffset:CGPointMake(self.collectionView.contentOffset.x -self.view.frame.size.width, 0) animated:YES];
        self.isInAction = YES;
        double delayInSeconds = 0.4;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            self.isInAction = NO;
        });
    }
}

- (IBAction)didSwipeLeft
{
    if (!self.isInAction && self.collectionView.contentOffset.x + self.view.frame.size.width < self.collectionView.contentSize.width) {
        [self.collectionView setContentOffset:CGPointMake(self.collectionView.contentOffset.x + self.view.frame.size.width, 0) animated:YES];
        self .isInAction = YES;
        double delayInSeconds = 0.4;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            self.isInAction = NO;
        });
    }
}

#pragma mark -
#pragma mark UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer;
{
    return YES;
}

@end
