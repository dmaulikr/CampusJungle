//
//  CCPhotoBrowserController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 21.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCPhotoBrowserController.h"
#import "CCCommonCollectionDataSource.h"
#import "CCDefines.h"
#import "CCPhotoCell.h"

@interface CCPhotoBrowserController () <CCCellSelectionProtocol>


@property (nonatomic, weak) IBOutlet UICollectionView *photoBrowser;
@property (nonatomic, weak) IBOutlet UINavigationItem *navigationBarItem;

@property (nonatomic, strong) CCCommonCollectionDataSource *dataSource;
@property (nonatomic) BOOL isInAction;

@end

@implementation CCPhotoBrowserController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addRightNavBarButton];
    [self configCollection:self.photoBrowser WithProvider:self.dataProvider cellClass:[CCPhotoCell class]];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSArray *photos = self.dataProvider.arrayOfItems;
    NSInteger index = [photos indexOfObject:self.firstPhoto];
    [self.photoBrowser setContentOffset:CGPointMake( index * self.view.frame.size.width, 0) animated:NO];
}

- (void)addRightNavBarButton
{
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                           style:UIBarButtonItemStyleBordered
                                                                          target:self
                                                                          action:@selector(doneButtonDidPressed:)];
    [self.navigationBarItem setRightBarButtonItem:rightBarButtonItem animated:YES];
}

- (void)configCollection:(UICollectionView *)collectionView WithProvider:(CCBaseDataProvider *)provider cellClass:(Class)cellCass
{
    self.dataSource = [CCCommonCollectionDataSource new];
    
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

}

- (IBAction)didSwipeRight
{
    if(!self.isInAction && self.photoBrowser.contentOffset.x > 0){
        [self.photoBrowser setContentOffset:CGPointMake(self.photoBrowser.contentOffset.x -self.view.frame.size.width, 0) animated:YES];
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
    if(!self.isInAction && self.photoBrowser.contentOffset.x + self.view.frame.size.width < self.photoBrowser.contentSize.width){
        [self.photoBrowser setContentOffset:CGPointMake(self.photoBrowser.contentOffset.x + self.view.frame.size.width, 0) animated:YES];
        self .isInAction = YES;
        double delayInSeconds = 0.4;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            self.isInAction = NO;
        });
    }
}

- (void)doneButtonDidPressed:(id)sender
{
    [self.closeTransaction perform];
}

@end
