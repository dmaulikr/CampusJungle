//
//  CCAdCell.m
//  CampusJungle
//
//  Created by Yury Grinenko on 02.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAdCell.h"
#import "CCAd.h"

@interface CCAdCell ()

@property (nonatomic, weak) IBOutlet UIImageView *adImageView;

@property (nonatomic, strong) CCAd *ad;

@end

@implementation CCAdCell

- (void)setCellObject:(CCAd *)ad
{
    self.ad = ad;
    [self fillImageView];
}

- (void)fillImageView
{
    NSString *adImagePath = [NSString stringWithFormat:@"%@%@", CCAPIDefines.baseURL, self.ad.normalizedImageUrl];
    [self.adImageView setImageWithURL:[NSURL URLWithString:adImagePath]];
}

@end
