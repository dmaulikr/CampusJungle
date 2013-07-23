//
//  CCUserCell.m
//  CampusJungle
//
//  Created by Vlad Korzun on 05.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCUserCell.h"
#import "CCUser.h"
#import "CCDefines.h"

@interface CCUserCell()

@property (nonatomic, weak) IBOutlet UILabel *userName;
@property (nonatomic, weak) IBOutlet UIImageView *avatar;

@end

@implementation CCUserCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil][0];
    }
    return self;
}

- (void)setCellObject:(id)cellObject
{
    [self setSelectionColor];
    _cellObject = cellObject;
    CCUser *currentUser = cellObject;
    self.userName.text = [NSString stringWithFormat:@"%@ %@",currentUser.firstName,currentUser.lastName];
    NSString *avatarPath = [NSString stringWithFormat:@"%@%@",CCAPIDefines.baseURL,currentUser.avatar];
    [self.avatar setImageWithURL:[NSURL URLWithString:avatarPath] placeholderImage:[UIImage imageNamed:@"avatar_placeholder"]];
    
}

+ (CGFloat)heightForCellWithObject:(id)object
{
    return 50.;
}

@end
