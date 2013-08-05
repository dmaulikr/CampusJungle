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

- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class])
                                              owner:self
                                            options:nil] objectAtIndex:0];
    }
    return self;
}

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
