//
//  CCSideMenuItemCell.m
//  CampusJungle
//
//  Created by Vlad Korzun on 29.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCSideMenuItemCell.h"
#import "CCMenuDefines.h"

@interface CCSideMenuItemCell()

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UIImageView *imageView;

@end

@implementation CCSideMenuItemCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] objectAtIndex:0];
    }
    return self;
}

- (void)fillWithObject:(id)object
{
    NSString *text = (NSString *)object;
    [self setTextString:text];    
    [self setImageForText:text];
}

- (void)setTextString:(NSString *)text
{
    [self.titleLabel setText:text];
}

- (void)setImageForText:(NSString *)text
{
    UIImage *image;
    if ([text isEqualToString:CCSideMenuTitles.newsFeed]) {
        image = [UIImage imageNamed:@"news_feed_icon.png"];
    }
    else {
        image = [UIImage imageNamed:@"marketPlaceLogo.png"];
    }
    [self.imageView setImage:image];
}

@end
