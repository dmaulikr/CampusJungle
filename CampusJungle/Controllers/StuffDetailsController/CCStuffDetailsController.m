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
#import "CCCommonCollectionDataSource.h"
#import "CCPhotosDataProvider.h"
#import "CCPhotoCell.h"

@interface CCStuffDetailsController ()<CCCellSelectionProtocol>

@property (nonatomic, weak) IBOutlet UIImageView *thumb;
@property (nonatomic, weak) IBOutlet UILabel *stuffDescription;
@property (nonatomic, weak) IBOutlet UICollectionView *stuffPhotos;
@property (nonatomic, strong) CCCommonCollectionDataSource *dataSource;
@property (nonatomic, strong) CCPhotosDataProvider *dataProvider;

@end

@implementation CCStuffDetailsController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.stuffDescription.text = self.stuff.description;
    
    self.dataProvider = [CCPhotosDataProvider new];
    self.dataProvider.photos = self.stuff.photos;
    
    [self configCollection:self.stuffPhotos WithProvider:self.dataProvider cellClass:[CCPhotoCell class]];
    
    if(self.stuff.thumbnailRetina.length){
        NSURL *thumbURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",CCAPIDefines.baseURL,self.stuff.thumbnailRetina]];
        [self.thumb setImageWithURL:thumbURL];
    } else {
        self.thumb.image = [UIImage imageNamed:@"stuff_placeholder_icon_active"];
    }
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

- (void)didSelectedCellWithObject:(id)cellObject
{
    [self.photoBrowserTransaction performWithObject:@{
            @"photosProvider" : self.dataProvider,
            @"selectedPhoto" : cellObject,
     }];
}

@end
