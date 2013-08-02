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

@interface CCCouponsViewController ()

@property (nonatomic, strong) CCClass *classObject;
@property (nonatomic, strong) CCAdsDataProvider *dataProvider;

@end

@implementation CCCouponsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setTitle:@"Coupons"];
}

- (void)configCollectrion
{
//    self.dataProvider = [CCAdsDataProvider new];
//    [self.dataProvider setClassId:self.classObject.classID];
//    [self configCollection:self.photoBrowser WithProvider:self.dataProvider cellClass:[CCAdCell class]];
}

@end
